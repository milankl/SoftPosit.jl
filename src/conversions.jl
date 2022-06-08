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

# corresponding float types for round-free conversion (they don't match in bitsize though!)
Base.floattype(::Type{Posit8}) = Float32        # Posit8, 16 are subsets of Float32
Base.floattype(::Type{Posit16}) = Float32
Base.floattype(::Type{Posit16_1}) = Float32
Base.floattype(::Type{Posit32}) = Float64       # Posit32 is a subset of Float64

# generic conversion to float
Base.float(x::AbstractPosit) = convert(Base.floattype(typeof(x)),x)    

# BOOL
for PositType in (:Posit8, :Posit16, :Posit32, :Posit16_1)
    @eval begin
            $PositType(x::Bool) = x ? one($PositType) : zero($PositType)
            promote_rule(::Type{Bool},::Type{$PositType}) = $PositType
    end
end

# easier for development purposes
Posit8(x::UInt8)        = reinterpret(Posit8,x)
Posit16(x::UInt16)      = reinterpret(Posit16,x)
Posit16_1(x::UInt16)    = reinterpret(Posit16_1,x)
Posit32(x::UInt32)      = reinterpret(Posit32,x)

# BETWEEN Posits
# upcasting: append with zeros.
Posit16(x::Posit8) = (reinterpret(Base.uinttype(Posit8),x) % UInt16) << 8
Posit32(x::Posit8) = (reinterpret(Base.uinttype(Posit8),x) % UInt32) << 24
# Posit16_1(x::Posit8) not yet supported as number of exponents bits changes

# WITH INTEGERS
# promotions
promote_rule(::Type{Integer},::Type{T}) where {T<:AbstractPosit} = T

# FROM FLOATS
# Float16/64 use detour via Float32
Posit16(x::Float16) = Posit16(Float32(x))
Posit16(x::Float64) = Posit16(Float32(x))
Posit16_1(x::Float16) = Posit16_1(Float32(x))
Posit16_1(x::Float64) = Posit16_1(Float32(x))

function Posit16_1(x::Float32)
    ui = reinterpret(UInt32,x)	
    
    # REGIME AND EXPONENT BITS
    # exponent without the exponent bias 127
    e = reinterpret(Int32,(ui & 0x7f80_0000) >> 23) - Int32(127)    
    abs_e = abs(e)                          # exponent without sign
    signbit_e = signbit(e)                  # sign of exponent
    n_regimebits = (abs_e >> 1) + 1         # number of regime bits
    exponent_bit = abs_e & 0x1              # exponent bit from exponent odd = 3,5,...?

    # combine regime bit and exponent and then arithmetic bitshift them in for e.g. 111110_e_....
    regime_exponent = reinterpret(Int32,0x8000_0000 | (exponent_bit << 29)) >> n_regimebits

    # for x < 1 use two's complement to the regime and exponent bits to flip them correctly
    regime_exponent = signbit_e ? -regime_exponent : regime_exponent
    regime_exponent &= 0x7fff_ffff          # remove any sign that results from arith bitshift

    # MANTISSA - isolate mantissa bits and shift in position
    mantissa = (ui & 0x007f_ffff) >> (n_regimebits-6+signbit_e*(exponent_bit-1))		
    # add u/2 = 0x0000_7fff or 0x0000_8000 for tie to even
    u_half = 0x0000_7fff + ((mantissa >> 16) & 0x0000_0001)

    # combine regime, exponent and mantissa, round to nearest, tie to even
    p32 = (regime_exponent | mantissa) + u_half
    p16 = ((p32 >> 16) % UInt16) - (15 < n_regimebits < 64)    # after +u_half round down via >>

    # check for sign bit and apply two's complement for negative numbers
    p16 = signbit(x) ? -p16 : p16
    return reinterpret(Posit16_1,p16)
end

## TO FLOATS
# conversion to Float32,16
Float16(x::AbstractPosit) = Float16(Float64(x))
Float32(x::AbstractPosit) = Float32(Float64(x))
Float16(x::Posit16) = Float16(Float32(x))
Float64(x::Posit16) = Float64(Float32(x))

function Float32(x::Posit16_1)
    ui = reinterpret(UInt16,x)

    signbitx = signbit(x)                   # sign of number
    abs_p16 = (signbitx ? -ui : ui) << 1    # two's complement for negative, remove sign bit

    # determine exponent sign from 2nd bit: 1=x>
    sign_exponent = reinterpret(Bool,((abs_p16 & 0x8000) >> 15) % UInt8)
    n_regimebits = sign_exponent ? leading_ones(abs_p16) : leading_zeros(abs_p16)
    
    # extract exponent and mantissa bits
    exponent_bit = ((abs_p16 << (n_regimebits+1)) & 0x8000) >> 15
    mantissa = ((abs_p16 << (n_regimebits + 2)) % UInt32) << 7

    # assemble float exponent from posit # of regime bits and exponent bit
    exponent = ((sign_exponent ? n_regimebits : -n_regimebits+1) << 1) + exponent_bit + 125
    
    # set exponent (and 1st mantissa bit) to NaN for NaR inputs
    # set exponent to 0 for zero(Posit16) input
    exponent = n_regimebits == 16 ? signbitx*0x7fc00000 : (exponent % UInt32) << 23

    # assemble sign, exponent and mantissa bits
    sign = (signbitx % UInt32) << 31		# isolate sign bit
    f32 = sign | exponent | mantissa		# concatenate sign, exponent and mantissa
    return reinterpret(Float32,f32)
end

function Base.Float32(x::Posit8)
    ui = unsigned(x)                        # as unsigned integer
    signbitx = signbit(x)                   # sign of number
    abs_p8 = signbitx ? -ui : ui            # two's complement for negative
    abs_p8 <<= 1                            # push signbit over the edge

    # determine exponent sign from 2nd bit
    sign_exponent = reinterpret(Bool,(abs_p8 & 0x80) >> 7)

    # number of regime bits
    n_regimebits = sign_exponent ? leading_ones(abs_p8) : leading_zeros(abs_p8)

    # MANTISSA BITS extract by shifting in position for Float32 and masking sign & exponent
    mantissa = ((abs_p8 % UInt32) << (n_regimebits + 18)) & Base.significand_mask(Float32)
    
    # EXPONENT BITS extract by shifting regime bits over the edge and push back to the tail
    exponent_bits = (abs_p8 << (n_regimebits+1)) >> 6

    # ASSEMBLE FLOAT EXPONENT
    # useed^k * 2^e = 2^(4k+e), ie get k-value from number of exponent bits,
    # <<2 for *4, add exponent bits and Float32 exponent bias (=127)
    k = (-1+2sign_exponent)*n_regimebits - sign_exponent
    exponent = ((k << 2) + exponent_bits + Base.exponent_bias(Float32)) % UInt32
    exponent <<= Base.significand_bits(Float32)
    
    # set exponent (and 1st mantissa bit) to NaN for NaR inputs
    # set exponent to 0 for zero(Posit8) input
    nan = reinterpret(UInt32,NaN32)
    exponent = n_regimebits == 8 ? (signbitx ? nan : zero(exponent)) : exponent

    # assemble sign, exponent and mantissa bits
    sign = (signbitx % UInt32) << 31        # isolate sign bit
    f32 = sign | exponent | mantissa		# concatenate sign, exponent and mantissa
    return reinterpret(Float32,f32)
end

function Base.Float32(x::Posit16)
    ui = unsigned(x)                        # as unsigned integer
    signbitx = signbit(x)                   # sign of number
    abs_p16 = signbitx ? -ui : ui           # two's complement for negative
    abs_p16 <<= 1                           # push signbit over the edge

    # determine exponent sign from 2nd bit
    sign_exponent = reinterpret(Bool,((abs_p16 & 0x8000) >> 15) % UInt8)

    # number of regime bits
    n_regimebits = sign_exponent ? leading_ones(abs_p16) : leading_zeros(abs_p16)

    # MANTISSA BITS extract by shifting in position for Float32 and masking sign & exponent
    mantissa = ((abs_p16 % UInt32) << (n_regimebits + 9)) & Base.significand_mask(Float32)
    
    # EXPONENT BITS extract by shifting regime bits over the edge and push back to the tail
    exponent_bits = (abs_p16 << (n_regimebits+1)) >> 14

    # ASSEMBLE FLOAT EXPONENT
    # useed^k * 2^e = 2^(4k+e), ie get k-value from number of exponent bits,
    # <<2 for *4, add exponent bits and Float32 exponent bias (=127)
    k = (-1+2sign_exponent)*n_regimebits - sign_exponent
    exponent = ((k << 2) + exponent_bits + Base.exponent_bias(Float32)) % UInt32
    exponent <<= Base.significand_bits(Float32)
    
    # set exponent (and 1st mantissa bit) to NaN for NaR inputs
    # set exponent to 0 for zero(Posit8) input
    nan = reinterpret(UInt32,NaN32)
    exponent = n_regimebits == 16 ? (signbitx ? nan : zero(exponent)) : exponent

    # assemble sign, exponent and mantissa bits
    sign = (signbitx % UInt32) << 31        # isolate sign bit
    f32 = sign | exponent | mantissa		# concatenate sign, exponent and mantissa
    return reinterpret(Float32,f32)
end

function Base.Float64(x::Posit32)
    ui = unsigned(x)                        # as unsigned integer
    signbitx = signbit(x)                   # sign of number
    abs_p32 = signbitx ? -ui : ui           # two's complement for negative
    abs_p32 <<= 1                           # push signbit over the edge

    # determine exponent sign from 2nd bit
    sign_exponent = reinterpret(Bool,((abs_p32 & 0x8000_0000) >> 31) % UInt8)

    # number of regime bits
    n_regimebits = sign_exponent ? leading_ones(abs_p32) : leading_zeros(abs_p32)

    # MANTISSA BITS extract by shifting in position for Float32 and masking sign & exponent
    mantissa = ((abs_p32 % UInt64) << (n_regimebits + 23)) & Base.significand_mask(Float64)
    
    # EXPONENT BITS extract by shifting regime bits over the edge and push back to the tail
    exponent_bits = (abs_p32 << (n_regimebits+1)) >> 30

    # ASSEMBLE FLOAT EXPONENT
    # useed^k * 2^e = 2^(4k+e), ie get k-value from number of exponent bits,
    # <<2 for *4, add exponent bits and Float32 exponent bias (=127)
    k = (-1+2sign_exponent)*n_regimebits - sign_exponent
    exponent = ((k << 2) + exponent_bits + Base.exponent_bias(Float64)) % UInt64
    exponent <<= Base.significand_bits(Float64)
    
    # set exponent (and 1st mantissa bit) to NaN for NaR inputs
    # set exponent to 0 for zero(Posit8) input
    nan = reinterpret(UInt64,NaN)
    exponent = n_regimebits == 32 ? (signbitx ? nan : zero(exponent)) : exponent

    # assemble sign, exponent and mantissa bits
    sign = (signbitx % UInt64) << 63        # isolate sign bit
    f64 = sign | exponent | mantissa		# concatenate sign, exponent and mantissa
    return reinterpret(Float64,f64)
end