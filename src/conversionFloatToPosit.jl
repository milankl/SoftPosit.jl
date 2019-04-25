# from Float64 to Posit8,16,32
Posit8(x::Float64) = ccall((:convertDoubleToP8, SoftPositPath), Posit8, (Float64,),x)
Posit16(x::Float64) = ccall((:convertDoubleToP16, SoftPositPath), Posit16, (Float64,),x)
Posit32(x::Float64) = ccall((:convertDoubleToP32, SoftPositPath), Posit32, (Float64,),x)

# from Float32/16 to Posit8,16,32
Posit8(x::T where {T <: Float16or32}) = Posit8(Float64(x))
Posit16(x::T where {T <: Float16or32}) = Posit16(Float64(x))
Posit32(x::T where {T <: Float16or32}) = Posit32(Float64(x))

# from Float64 to Posit_1
Posit8_1(x::Float64) = ccall((:convertDoubleToPX1, SoftPositPath), Posit8_1, (Float64,Int64),x,8)
Posit16_1(x::Float64) = ccall((:convertDoubleToPX1, SoftPositPath), Posit16_1, (Float64,Int64),x,16)
Posit24_1(x::Float64) = ccall((:convertDoubleToPX1, SoftPositPath), Posit24_1, (Float64,Int64),x,24)

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
