# from Posit to Float64,32,16
Float64(x::Posit8) = ccall((:convertP8ToDouble, SoftPositPath), Float64, (Posit8,),x)
Float64(x::Posit16) = ccall((:convertP16ToDouble, SoftPositPath), Float64, (Posit16,),x)
Float64(x::Posit32) = ccall((:convertP32ToDouble, SoftPositPath), Float64, (Posit32,),x)

Float32(x::AbstractPosit) = Float32(Float64(x))
Float16(x::AbstractPosit) = Float16(Float64(x))

# conversion from PX2 to Float64,32,16
Float64(x::Posit8_2) = ccall((:convertPX2ToDouble, SoftPositPath), Float64, (Posit8_2,),x)
Float64(x::Posit16_2) = ccall((:convertPX2ToDouble, SoftPositPath), Float64, (Posit16_2,),x)
Float64(x::Posit24_2) = ccall((:convertPX2ToDouble, SoftPositPath), Float64, (Posit24_2,),x)

Float32(x::Posit_2) = Float32(Float64(x))
Float16(x::Posit_2) = Float16(Float64(x))



# from Float64 to Posit
Posit8(x::Float64) = ccall((:convertDoubleToP8, SoftPositPath), Posit8, (Float64,),x)
Posit16(x::Float64) = ccall((:convertDoubleToP16, SoftPositPath), Posit16, (Float64,),x)
Posit32(x::Float64) = ccall((:convertDoubleToP32, SoftPositPath), Posit32, (Float64,),x)

# from Float32/16 to Posit
Posit8(x::T where {T <: Float16or32}) = Posit8(Float64(x))
Posit16(x::T where {T <: Float16or32}) = Posit16(Float64(x))
Posit32(x::T where {T <: Float16or32}) = Posit32(Float64(x))



# direct conversion from hexadecimal or binary
Posit8(x::UInt8) = reinterpret(Posit8,x)
Posit16(x::UInt16) = reinterpret(Posit16,x)
Posit32(x::UInt32) = reinterpret(Posit32,x)

Posit8_2(x::UInt32) = reinterpret(Posit8_2,x)
Posit16_2(x::UInt32) = reinterpret(Posit16_2,x)
Posit24_2(x::UInt32) = reinterpret(Posit24_2,x)

# allow also 8bit and 16bit although internally stored as 32bit
# shift bits as conversion to UInt32 adds 0 bits to the left
# but the posit formats assume 0 bits at the right for 8,16bit
Posit8_2(x::UInt8) = Posit8_2(UInt32(x) << 24)
Posit16_2(x::UInt16) = Posit16_2(UInt32(x) << 16)



# fom Integer to Posit
Posit8(x::Int64) = ccall((:i64_to_p8, SoftPositPath), Posit8, (Int64,),x)
Posit8(x::Int32) = ccall((:i32_to_p8, SoftPositPath), Posit8, (Int32,),x)

Posit16(x::Int64) = ccall((:i64_to_p16, SoftPositPath), Posit16, (Int64,),x)
Posit16(x::Int32) = ccall((:i32_to_p16, SoftPositPath), Posit16, (Int32,),x)

Posit32(x::Int64) = ccall((:i64_to_p32, SoftPositPath), Posit32, (Int64,),x)
Posit32(x::Int32) = ccall((:i32_to_p32, SoftPositPath), Posit32, (Int32,),x)



# from Posit to Integer
Int64(x::Posit8) = ccall((:p8_to_i64, SoftPositPath), Int64, (Posit8,),x)
Int64(x::Posit16) = ccall((:p16_to_i64, SoftPositPath), Int64, (Posit16,),x)
Int64(x::Posit32) = ccall((:p32_to_i64, SoftPositPath), Int64, (Posit32,),x)

Int32(x::Posit8) = ccall((:p8_to_i32, SoftPositPath), Int32, (Posit8,),x)
Int32(x::Posit16) = ccall((:p16_to_i32, SoftPositPath), Int32, (Posit16,),x)
Int32(x::Posit32) = ccall((:p32_to_i32, SoftPositPath), Int32, (Posit32,),x)



# conversion between Posit8, Posit16 and Posit32
Posit8(x::Posit16) = ccall((:p16_to_p8, SoftPositPath), Posit8, (Posit16,),x)
Posit32(x::Posit16) = ccall((:p16_to_p32, SoftPositPath), Posit32, (Posit16,),x)
Posit8(x::Posit32) = ccall((:p32_to_p8, SoftPositPath), Posit8, (Posit32,),x)
Posit16(x::Posit32) = ccall((:p32_to_p16, SoftPositPath), Posit16, (Posit32,),x)
Posit16(x::Posit8) = ccall((:p8_to_p16, SoftPositPath), Posit16, (Posit8,),x)
Posit32(x::Posit8) = ccall((:p8_to_p32, SoftPositPath), Posit32, (Posit8,),x)



# conversion between Posit8, 16 and 32 to PX2
Posit8_2(x::Posit8) = ccall((:p8_to_pX2, SoftPositPath), Posit8_2, (Posit8,Int64),x,8)
Posit16_2(x::Posit8) = ccall((:p8_to_pX2, SoftPositPath), Posit16_2, (Posit8,Int64),x,16)
Posit24_2(x::Posit8) = ccall((:p8_to_pX2, SoftPositPath), Posit24_2, (Posit8,Int64),x,24)

Posit8_2(x::Posit16) = ccall((:p16_to_pX2, SoftPositPath), Posit8_2, (Posit16,Int64),x,8)
Posit16_2(x::Posit16) = ccall((:p16_to_pX2, SoftPositPath), Posit16_2, (Posit16,Int64),x,16)
Posit24_2(x::Posit16) = ccall((:p16_to_pX2, SoftPositPath), Posit24_2, (Posit16,Int64),x,24)

Posit8_2(x::Posit32) = ccall((:p32_to_pX2, SoftPositPath), Posit8_2, (Posit32,Int64),x,8)
Posit16_2(x::Posit32) = ccall((:p32_to_pX2, SoftPositPath), Posit16_2, (Posit32,Int64),x,16)
Posit24_2(x::Posit32) = ccall((:p32_to_pX2, SoftPositPath), Posit24_2, (Posit32,Int64),x,24)
