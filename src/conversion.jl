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
