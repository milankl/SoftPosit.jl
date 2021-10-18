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

function Float32_new(x::Posit16)
    ui = reinterpret(UInt16,x)

	signbitx = signbit(x)
	abs_p16 = (signbitx ? -ui : ui) << 1
	sign_exponent = reinterpret(Bool,((abs_p16 & 0x8000) >> 15) % UInt8)
	n_regimebits = sign_exponent ? leading_ones(abs_p16) : leading_zeros(abs_p16)
	
	# extract exponent and mantissa bits
	exponent_bit = Int64(((abs_p16 << (n_regimebits+1)) & 0x8000) >> 15)
	mantissa = ((abs_p16 << (n_regimebits + 2)) % UInt32) << 7

	# assemble float exponent from posit # of regime bits and exponent bit
	exponent = ((sign_exponent ? n_regimebits : -n_regimebits+1) << 1) + exponent_bit + 125
	exponent = (exponent % UInt32) << 23

	# assemble sign, exponent and mantissa bits
	sign = (signbitx % UInt32) << 31		# isolate sign bit
	f32 = sign | exponent | mantissa		# concatenate sign, exponent and mantissa
	return reinterpret(Float32,f32)
end