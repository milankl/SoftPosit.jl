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
Base.unsigned(x::AbstractPosit) = reinterpret(Base.uinttype(typeof(x)),x)
Base.signed(x::AbstractPosit) = reinterpret(Base.inttype(typeof(x)),x)

# BOOL
for PositType in (:Posit8, :Posit16, :Posit32, :Posit16_1)
    @eval begin
            $PositType(x::Bool) = x ? one($PositType) : zero($PositType)
            Base.promote_rule(::Type{Bool},::Type{$PositType}) = $PositType
    end
end

# easier for development purposes
Posit8(x::UInt8)        = reinterpret(Posit8,x)
Posit16(x::UInt16)      = reinterpret(Posit16,x)
Posit16_1(x::UInt16)    = reinterpret(Posit16_1,x)
Posit32(x::UInt32)      = reinterpret(Posit32,x)

# BETWEEN Posits
# upcasting: append with zeros.
Posit16(x::Posit8) = (unsigned(x) % UInt16) << 8
Posit32(x::Posit8) = (unsigned(x) % UInt32) << 24
Posit32(x::Posit16) = (unsigned(x) % UInt32) << 16

# downcasting: apply round to nearest
Posit8(x::Posit16) = posit(Posit8,x)
Posit8(x::Posit32) = posit(Posit8,x)
Posit16(x::Posit32) = posit(Posit16,x)

function posit(::Type{PositN1},x::PositN2) where {PositN1<:AbstractPosit,PositN2<:AbstractPosit}
    ui = unsigned(x)                                # unsigned integer corresponding to input
    ui = signbit(x) ? -ui : ui                      # round in positive, convert back later
    Δbits = bitsize(PositN2) - bitsize(PositN1)     # difference in bits

    # ROUND TO NEAREST
    # tie to even: create ulp/2 = ..007ff.. or ..0080..
    ulp_half = ~Base.sign_mask(PositN2) >> bitsize(PositN1) # create ..007ff.. (just smaller than ulp/2)
    ulp_half += ((ui >> Δbits) & 0x1)                       # turn into ..0080.. for odd (=round up if tie)
    ui += ulp_half
    ui_trunc = ((ui >> Δbits) % Base.uinttype(PositN1))     # +ulp/2 and round down = round nearest
    ui_trunc = signbit(x) ? -ui_trunc : ui_trunc            # undo two's complement for negative numbers
    return reinterpret(PositN1,ui_trunc)
end

# Due to only 1 exponent bit define Posit16_1(::AbstractPosit) via float conversion
Posit16_1(x::T) where {T<:Union{Posit8,Posit16,Posit32}} = Posit16_1(float(x))



# WITH INTEGERS
# promotions
Base.promote_rule(::Type{Integer},::Type{T}) where {T<:AbstractPosit} = T

# FROM FLOATS
Posit8(x::T) where {T<:Base.IEEEFloat} = posit(Posit8,x)
Posit16(x::T) where {T<:Base.IEEEFloat} = posit(Posit16,x)
Posit16_1(x::T) where {T<:Base.IEEEFloat} = posit(Posit16_1,x)
Posit32(x::T) where {T<:Base.IEEEFloat} = posit(Posit32,x)

function posit(::Type{PositN},x::FloatN) where {PositN<:AbstractPosit,FloatN<:Base.IEEEFloat}

    UIntN = Base.uinttype(FloatN)           # unsigned integer corresponding to FloatN
    IntN = Base.inttype(FloatN)             # signed integer corresponding to FloatN
    ui = reinterpret(UIntN,x)               # reinterpret input

    # REGIME AND EXPONENT BITS
    # extract exponent bits and shift to tail, then remove bias
    e = (ui & Base.exponent_mask(FloatN)) >> Base.significand_bits(FloatN)
    e = reinterpret(IntN,e) - IntN(Base.exponent_bias(FloatN))
    abs_e = abs(e)                          # exponent without sign
    signbit_e = signbit(e)                  # sign of exponent                                 
    n_regimebits = (abs_e >> Base.exponent_bits(PositN)) + 1    # number of regime bits
    exponent_bits = abs_e & Base.exponent_mask(PositN)          # exponent from tail of float exponent

    # combine regime bit and exponent and then arithmetic bitshift them in for e.g. 111110_e_....
    regime_exponent = Base.sign_mask(FloatN) | (exponent_bits << (bitsize(FloatN)-2-Base.exponent_bits(PositN)))
    regime_exponent = reinterpret(IntN,regime_exponent) >> n_regimebits

    # for x < 1 use two's complement to the regime and exponent bits to flip them correctly
    regime_exponent = signbit_e ? -regime_exponent : regime_exponent
    regime_exponent &= ~Base.sign_mask(FloatN)  # remove any sign that results from arith bitshift
    regime_exponent = reinterpret(UIntN,regime_exponent)

    # MANTISSA 
    Δbits = bitsize(FloatN) - bitsize(PositN)                   # difference in bits
    mantissa = (ui & Base.significand_mask(FloatN))             # extract mantissa bits
    mantissa >>= (n_regimebits + Base.exponent_bits(PositN) -   # shift in position for posit
                    Base.exponent_bits(FloatN)+1)
    
    # tie to even: create ulp/2 = ..007ff.. or ..0080..
    ulp_half = ~Base.sign_mask(FloatN) >> bitsize(PositN)       # create ..007ff.. (just smaller than ulp/2)
    ulp_half += ((mantissa >> Δbits) & 0x1)                     # turn into ..0080.. for odd (=round up if tie)

    p = (regime_exponent | mantissa) + ulp_half                 # combine regime, exponent and mantissa
    p_trunc = ((p >> Δbits) % Base.uinttype(PositN))            # +ulp/2 and round down = round nearest

    p_trunc = signbit(x) ? -p_trunc : p_trunc                   # two's complement for negative numbers
    return reinterpret(PositN,p_trunc)
end

## TO FLOATS
# corresponding float types for round-free conversion (they don't match in bitsize though!)
Base.floattype(::Type{Posit8}) = Float32        # Posit8, 16 are subsets of Float32
Base.floattype(::Type{Posit16}) = Float32
Base.floattype(::Type{Posit16_1}) = Float32
Base.floattype(::Type{Posit32}) = Float64       # Posit32 is a subset of Float64

# generic conversion to float
Base.float(x::AbstractPosit) = convert(Base.floattype(typeof(x)),x)    

Base.Float16(x::AbstractPosit) = float(Float16,x)
Base.Float32(x::AbstractPosit) = float(Float32,x)
Base.Float64(x::AbstractPosit) = float(Float64,x)

function Base.float(::Type{FloatN},x::PositN) where {FloatN<:Base.IEEEFloat,PositN<:AbstractPosit}
    
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
    shift = mantissa_shift(FloatN,PositN)
    mantissa = ((absx % UIntN) << (n_regimebits + shift)) & Base.significand_mask(FloatN)
    
    # EXPONENT BITS extract by shifting regime bits over the edge and push back to the tail
    exponent_bits = (absx << (n_regimebits+1)) >> (n_bits-Base.exponent_bits(PositN))

    # ASSEMBLE FLOAT EXPONENT
    # useed^k * 2^e = 2^(2^n_exponent_bits*k+e), ie get k-value from number of regime bits,
    # <<2 for *4, add exponent bits and Float32 exponent bias (=127)
    k = (-1+2sign_exponent)*n_regimebits - sign_exponent
    exponent = ((k << Base.exponent_bits(PositN)) + exponent_bits + Base.exponent_bias(FloatN)) % UIntN
    exponent <<= Base.significand_bits(FloatN)
    
    # set exponent (and 1st mantissa bit) to NaN for NaR inputs
    # set exponent to 0 for zero(Posit8) input
    nan_ui = reinterpret(UIntN,nan(FloatN))
    exponent = n_regimebits == n_bits ? (signbitx ? nan_ui : zero(exponent)) : exponent

    # assemble sign, exponent and mantissa bits
    sign = signbitx*Base.sign_mask(FloatN)
    f = sign | exponent | mantissa		    # concatenate sign, exponent and mantissa
    return reinterpret(FloatN,f)
end