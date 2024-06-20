# corresponding UInt types
Base.uinttype(::Type{Posit8}) = UInt8
Base.uinttype(::Type{Posit16}) = UInt16
Base.uinttype(::Type{Posit16_1}) = UInt16
Base.uinttype(::Type{Posit32}) = UInt32

# corresponding Int types
Base.inttype(::Type{Posit8}) = Int8
Base.inttype(::Type{Posit16}) = Int16
Base.inttype(::Type{Posit16_1}) = Int16
Base.inttype(::Type{Posit32}) = Int32

# generic conversion to UInt/Int
Base.unsigned(x::AbstractPosit) = reinterpret(Base.uinttype(typeof(x)), x)
Base.signed(x::AbstractPosit) = reinterpret(Base.inttype(typeof(x)), x)

# BOOL
for PositType in (:Posit8, :Posit16, :Posit32, :Posit16_1)
    @eval begin
        $PositType(x::Bool) = x ? one($PositType) : zero($PositType)
        Base.promote_rule(::Type{Bool}, ::Type{$PositType}) = $PositType
    end
end

# easier for development purposes
Posit8(x::UInt8)        = reinterpret(Posit8, x)
Posit16(x::UInt16)      = reinterpret(Posit16, x)
Posit16_1(x::UInt16)    = reinterpret(Posit16_1, x)
Posit32(x::UInt32)      = reinterpret(Posit32, x)

# BETWEEN Posits
# upcasting: append with zeros.
Posit16(x::Posit8) = reinterpret(Posit16, (unsigned(x) % UInt16) << 8)
Posit32(x::Posit8) = reinterpret(Posit32, (unsigned(x) % UInt32) << 24)
Posit32(x::Posit16) = reinterpret(Posit32, (unsigned(x) % UInt32) << 16)

# downcasting: apply round to nearest
Posit8(x::Posit16) = posit(Posit8, x)
Posit8(x::Posit32) = posit(Posit8, x)
Posit16(x::Posit32) = posit(Posit16, x)

# conversion to and from Posit16_1 via floats as number of exponent bits changes
Posit16_1(x::AbstractPosit) = Posit16_1(float(x))
Posit8(x::Posit16_1) = Posit8(float(x))
Posit16(x::Posit16_1) = Posit16(float(x))
Posit32(x::Posit16_1) = Posit32(float(x))

function posit(::Type{PositN1}, x::PositN2) where {PositN1<:AbstractPosit, PositN2<:AbstractPosit}
    return reinterpret(PositN1, bitround(Base.uinttype(PositN1), unsigned(x)))
end

# bitrounding for upcasting (append with zeros) and downcasting (=rounding)
function bitround(::Type{UIntN1}, ui::UIntN2) where {UIntN1<:Unsigned, UIntN2<:Unsigned}
    Δbits = bitsize(UIntN2) - bitsize(UIntN1)               # difference in bit sizes

    # ROUND TO NEAREST, tie to even: create ulp/2 = ..007ff.. or ..0080..
    ulp_half = ~Base.sign_mask(UIntN2) >> bitsize(UIntN1)   # create ..007ff.. (just smaller than ulp/2)
    ulp_half += ((ui >> Δbits) & 0x1)                       # turn into ..0080.. for odd (=round up if tie)
    ui += ulp_half                                          # +ulp/2 and

    # round down via >> is round nearest, but use % UInt64 in case of upcasting to not lose any bits
    # and append with zeros
    ui_trunc = ((ui % UInt64) >> Δbits) % UIntN1            
    return ui_trunc
end

# identity for identical uints (no rounding)
bitround(::Type{UIntN}, ui::UIntN) where {UIntN<:Unsigned} = ui


# Due to only 1 exponent bit define Posit16_1(::AbstractPosit) via float conversion
Posit16_1(x::T) where {T<:Union{Posit8,Posit16,Posit32}} = Posit16_1(float(x))

# WITH INTEGERS
Posit8(x::Signed) = Posit8(Float64(x))
Posit16_1(x::Signed) = Posit16_1(Float64(x))
Posit16(x::Signed) = Posit16(Float64(x))
Posit32(x::Signed) = Posit32(Float64(x))

Base.Int(x::AbstractPosit) = Int(Float64(x))

# promotions
Base.promote_rule(::Type{Int}, ::Type{T}) where {T<:AbstractPosit} = T

# FROM FLOATS
Posit8(x::T) where {T<:Base.IEEEFloat} = posit(Posit8, x)
Posit16(x::T) where {T<:Base.IEEEFloat} = posit(Posit16, x)
Posit16_1(x::T) where {T<:Base.IEEEFloat} = posit(Posit16_1, x)
Posit32(x::T) where {T<:Base.IEEEFloat} = posit(Posit32, x)

function posit(::Type{PositN}, x::FloatN) where {PositN<:AbstractPosit, FloatN<:Base.IEEEFloat}

    UIntN = Base.uinttype(FloatN)           # unsigned integer corresponding to FloatN
    IntN = Base.inttype(FloatN)             # signed integer corresponding to FloatN
    ui = reinterpret(UIntN, x)              # reinterpret input

    # extract exponent bits and shift to tail, then remove bias
    e = (ui & Base.exponent_mask(FloatN)) >> Base.significand_bits(FloatN)
    e = reinterpret(IntN, e) - IntN(Base.exponent_bias(FloatN))
    signbit_e = signbit(e)                  # sign of exponent     
    k = e >> Base.exponent_bits(PositN)     # k-value for useed^k in posits

    # ASSEMBLE POSIT REGIME, EXPONENT, MANTISSA
    # get posit exponent_bits and shift to starting from bitposition 3 (they'll be shifted in later)
    exponent_bits = signed(e & Base.exponent_mask(PositN))
    exponent_bits <<= bitsize(FloatN)-2-Base.exponent_bits(PositN)

    # create 01000... (for |x|<1) or 10000... (|x| > 1)
    regime_bits = reinterpret(IntN, Base.sign_mask(FloatN) >> signbit_e)

    # extract mantissa bits and push to behind exponent rre..emm... (regime still hasn't been shifted)
    mantissa = reinterpret(IntN, ui & Base.significand_mask(FloatN))             
    mantissa <<= Base.exponent_bits(FloatN) - Base.exponent_bits(PositN) - 1

    # combine regime, exponent, mantissa and arithmetic bitshift for 11..110em or 00..001em
    regime_exponent_mantissa = regime_bits | exponent_bits | mantissa
    regime_exponent_mantissa >>= (abs(k+1) + signbit_e)     # arithmetic bitshift
    regime_exponent_mantissa &= ~Base.sign_mask(FloatN)     # remove possible sign bit from arith shift

    # round to nearest of the result
    p_rounded = bitround(Base.uinttype(PositN), unsigned(regime_exponent_mantissa))

    # no under or overflow rounding mode
    max_k = (Base.exponent_bias(FloatN) >> Base.exponent_bits(PositN)) + 1
    p_rounded -= Base.inttype(PositN)(sign(k)*(bitsize(PositN) <= abs(k) < max_k))

    p_rounded = signbit(x) ? -p_rounded : p_rounded         # two's complement for negative numbers
    
    return reinterpret(PositN, p_rounded)
end

## TO FLOATS
# corresponding float types for round-free conversion (they don't match in bitsize though!)
Base.floattype(::Type{Posit8}) = Float32        # Posit8, 16 are subsets of Float32
Base.floattype(::Type{Posit16}) = Float32
Base.floattype(::Type{Posit16_1}) = Float32
Base.floattype(::Type{Posit32}) = Float64       # Posit32 is a subset of Float64

# generic conversion to float
Base.float(x::AbstractPosit) = convert(Base.floattype(typeof(x)),x)    
Base.Float32(x::AbstractPosit) = float(Float32,x)
Base.Float64(x::AbstractPosit) = float(Float64,x)

# The dynamic range of Float16 is smaller than Posit8/16/32
# for correct rounding convert first to Float32/64
Base.Float16(x::Posit8) = Float16(float(Float32, x))
Base.Float16(x::Posit16) = Float16(float(Float32, x))
Base.Float16(x::Posit16_1) = Float16(float(Float32, x))
Base.Float16(x::Posit32) = Float16(float(Float64, x))

function Base.float(::Type{FloatN}, x::PositN) where {FloatN<:Base.IEEEFloat, PositN<:AbstractPosit}
    
    UIntN = Base.uinttype(FloatN)           # corresponding UInt for floattype
    n_bits = bitsize(PositN)                # number of bits in posit format
    ui = unsigned(x)                        # as unsigned integer
    signbitx = signbit(x)                   # sign of number
    absx = signbitx ? -ui : ui              # two's complement for negative
    absx <<= 1                              # push signbit over the edge

    # determine exponent sign from 2nd bit
    sign_exponent = reinterpret(Bool,(absx >> (n_bits-1)) % UInt8)

    # number of regime bits
    n_regimebits = sign_exponent ? leading_ones(absx) : leading_zeros(absx)

    # MANTISSA BITS extract by shifting in position for Float32 and masking sign & exponent
    n_non_exponent = n_bits - Base.exponent_bits(PositN)
    shift = bitsize(FloatN) - Base.exponent_bits(FloatN) - n_non_exponent
    mantissa = ((absx % UIntN) << (n_regimebits + shift)) & Base.significand_mask(FloatN)
    
    # EXPONENT BITS extract by shifting regime bits over the edge and push back to the tail
    exponent_bits = (absx << (n_regimebits+1)) >> n_non_exponent

    # ASSEMBLE FLOAT EXPONENT
    # useed^k * 2^e = 2^(2^n_exponent_bits*k+e), ie get k-value from number of regime bits,
    # << n_exponent_bits for *2^exponent_bits, add exponent bits and Float exponent bias (=15,127,1023)
    k = (-1+2sign_exponent)*n_regimebits - sign_exponent
    exponent = ((k << Base.exponent_bits(PositN)) + exponent_bits + Base.exponent_bias(FloatN)) % UIntN
    exponent <<= Base.significand_bits(FloatN)
    
    # set exponent (and 1st mantissa bit) to NaN for NaR inputs
    # set exponent to 0 for zero(Posit8) input
    nan_ui = reinterpret(UIntN, nan(FloatN))
    exponent = n_regimebits == n_bits ? (signbitx ? nan_ui : zero(exponent)) : exponent

    # assemble sign, exponent and mantissa bits
    sign = signbitx*Base.sign_mask(FloatN)
    f = sign | exponent | mantissa		    # concatenate sign, exponent and mantissa
    return reinterpret(FloatN, f)
end

# BIGFLOAT
Base.BigFloat(x::AbstractPosit) = BigFloat(Float64(x))
Posit8(x::BigFloat) = Posit8(Float64(x))
Posit16(x::BigFloat) = Posit16(Float64(x))
Posit16_1(x::BigFloat) = Posit16_1(Float64(x))
Posit32(x::BigFloat) = Posit32(Float64(x))

# IRRATIONALS
Posit8(x::Irrational) = Posit8(Base.floattype(Posit8)(x))
Posit16(x::Irrational) = Posit16(Base.floattype(Posit16)(x))
Posit16_1(x::Irrational) = Posit16_1(Base.floattype(Posit16_1)(x))
Posit32(x::Irrational) = Posit32(Base.floattype(Posit32)(x))
