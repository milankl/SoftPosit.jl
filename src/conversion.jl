# from Posit to Float64
Float64(x::Posit8) = ccall((:convertP8ToDouble, SoftPositPath), Float64, (Posit8,),x)
Float64(x::Posit16) = ccall((:convertP16ToDouble, SoftPositPath), Float64, (Posit16,),x)
Float64(x::Posit32) = ccall((:convertP32ToDouble, SoftPositPath), Float64, (Posit32,),x)

# from Posit to Float32, Float16
Float32(x::AbstractPosit) = Float32(Float64(x))
Float16(x::AbstractPosit) = Float16(Float64(x))

# from Float64 to Posit
Posit8(x::Float64) = ccall((:convertDoubleToP8, SoftPositPath), Posit8, (Float64,),x)
Posit16(x::Float64) = ccall((:convertDoubleToP16, SoftPositPath), Posit16, (Float64,),x)
Posit32(x::Float64) = ccall((:convertDoubleToP32, SoftPositPath), Posit32, (Float64,),x)

# from Float32 to Posit
Posit8(x::Float32) = ccall((:convertDoubleToP8, SoftPositPath), Posit8, (Float64,),Float64(x))
Posit16(x::Float32) = ccall((:convertDoubleToP16, SoftPositPath), Posit16, (Float64,),Float64(x))
Posit32(x::Float32) = ccall((:convertDoubleToP32, SoftPositPath), Posit32, (Float64,),Float64(x))

# from Float16 to Posit
Posit8(x::Float16) = ccall((:convertDoubleToP8, SoftPositPath), Posit8, (Float64,),Float64(x))
Posit16(x::Float16) = ccall((:convertDoubleToP16, SoftPositPath), Posit16, (Float64,),Float64(x))
Posit32(x::Float16) = ccall((:convertDoubleToP32, SoftPositPath), Posit32, (Float64,),Float64(x))

# direct conversion from hexadecimal or binary
Posit8(x::UInt8) = reinterpret(Posit8,x)
Posit16(x::UInt16) = reinterpret(Posit16,x)
Posit32(x::UInt32) = reinterpret(Posit32,x)

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

# round to nearest ties to even
round(x::Posit8) = ccall((:p8_roundToInt, SoftPositPath), Posit8, (Posit8,),x)
round(x::Posit16) = ccall((:p16_roundToInt, SoftPositPath), Posit16, (Posit16,),x)
round(x::Posit32) = ccall((:p32_roundToInt, SoftPositPath), Posit32, (Posit32,),x)

# conversion between Posit8, Posit16 and Posit32
Posit8(x::Posit16) = ccall((:p16_to_p8, SoftPositPath), Posit8, (Posit16,),x)
Posit32(x::Posit16) = ccall((:p16_to_p32, SoftPositPath), Posit32, (Posit16,),x)
Posit8(x::Posit32) = ccall((:p32_to_p8, SoftPositPath), Posit8, (Posit32,),x)
Posit16(x::Posit32) = ccall((:p32_to_p16, SoftPositPath), Posit16, (Posit32,),x)
Posit16(x::Posit8) = ccall((:p8_to_p16, SoftPositPath), Posit16, (Posit8,),x)
Posit32(x::Posit8) = ccall((:p8_to_p32, SoftPositPath), Posit32, (Posit8,),x)
