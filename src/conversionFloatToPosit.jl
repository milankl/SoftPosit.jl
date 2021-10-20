# from Float64 to Posit8,16,32
Posit8(x::Float64) = ccall((:convertDoubleToP8, SoftPositPath), Posit8, (Float64,),x)
Posit16(x::Float64) = ccall((:convertDoubleToP16, SoftPositPath), Posit16, (Float64,),x)
Posit32(x::Float64) = ccall((:convertDoubleToP32, SoftPositPath), Posit32, (Float64,),x)

# from Float32/16 to Posit8,16,32
Posit8(x::T where {T <: Float16or32}) = Posit8(Float64(x))
Posit16(x::T where {T <: Float16or32}) = Posit16(Float64(x))
Posit32(x::T where {T <: Float16or32}) = Posit32(Float64(x))

# from Float64 to Posit_1 (convertDoubleToPX1 currently not available)
# Posit8_1(x::Float64) = ccall((:convertDoubleToPX1, SoftPositPath), Posit8_1, (Float64,Int64),x,8)
# Posit16_1(x::Float64) = ccall((:convertDoubleToPX1, SoftPositPath), Posit16_1, (Float64,Int64),x,16)
# Posit24_1(x::Float64) = ccall((:convertDoubleToPX1, SoftPositPath), Posit24_1, (Float64,Int64),x,24)

# use detour
Posit8_1(x::Float64) = Posit8_1(Posit32(x))
Posit16_1(x::Float64) = Posit16_1(Posit32(x))
Posit24_1(x::Float64) = Posit24_1(Posit32(x))

# from Float32/16 to Posit_1
Posit8_1(x::T where {T <: Float16or32}) = Posit8_1(Float64(x))
Posit16_1(x::T where {T <: Float16or32}) = Posit16_1(Float64(x))
Posit24_1(x::T where {T <: Float16or32}) = Posit24_1(Float64(x))

# from Float64 to Posit_2
Posit8_2(x::Float64) = ccall((:convertDoubleToPX2, SoftPositPath), Posit8_2, (Float64,Int64),x,8)
Posit16_2(x::Float64) = ccall((:convertDoubleToPX2, SoftPositPath), Posit16_2, (Float64,Int64),x,16)
Posit24_2(x::Float64) = ccall((:convertDoubleToPX2, SoftPositPath), Posit24_2, (Float64,Int64),x,24)

# from Float32/16 to Posit_2
Posit8_2(x::T where {T <: Float16or32}) = Posit8_2(Float64(x))
Posit16_2(x::T where {T <: Float16or32}) = Posit16_2(Float64(x))
Posit24_2(x::T where {T <: Float16or32}) = Posit24_2(Float64(x))

function Posit16_new(x::Float32)
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
    return reinterpret(Posit16,p16)
end
