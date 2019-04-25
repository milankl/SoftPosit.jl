# from Posit to Float64,32,16
Float64(x::Posit8) = ccall((:convertP8ToDouble, SoftPositPath), Float64, (Posit8,),x)
Float64(x::Posit16) = ccall((:convertP16ToDouble, SoftPositPath), Float64, (Posit16,),x)
Float64(x::Posit32) = ccall((:convertP32ToDouble, SoftPositPath), Float64, (Posit32,),x)

# conversion from PX2 to Float64,32,16
Float64(x::Posit8_2) = ccall((:convertPX2ToDouble, SoftPositPath), Float64, (Posit8_2,),x)
Float64(x::Posit16_2) = ccall((:convertPX2ToDouble, SoftPositPath), Float64, (Posit16_2,),x)
Float64(x::Posit24_2) = ccall((:convertPX2ToDouble, SoftPositPath), Float64, (Posit24_2,),x)

# conversion from PX1 to Float64,32,16
Float64(x::Posit8_1) = ccall((:convertPX1ToDouble, SoftPositPath), Float64, (Posit8_1,),x)
Float64(x::Posit16_1) = ccall((:convertPX1ToDouble, SoftPositPath), Float64, (Posit16_1,),x)
Float64(x::Posit24_1) = ccall((:convertPX1ToDouble, SoftPositPath), Float64, (Posit24_1,),x)

# conversion to Float32,16
Float32(x::AbstractPosit) = Float32(Float64(x))
Float16(x::AbstractPosit) = Float16(Float64(x))
