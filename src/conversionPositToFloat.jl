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

# conversion between Posit16 and Float32
# from Moritz Lehmann, Uni Bayreuth
function Float32(x::Posit16)

    ui = reinterpret(UInt16,x)
	sr = (ui>>14) & 1      # sign of regime
	t = ui<<2              # remove sign and first regime bit
	t = sr ? ~t : t        # positive regime r>=0 : negative regime r<0
	
    # evil log2 bit hack to count leading zeros for regime
    r = 158-(as_int((float)((uint)t<<16))>>23); 
	
    e = (ui >> (12-r)) & 1              # extract mantissa and bit-shift it in place
	m = (ui << (r+11)) & 0x007f_ffff    # extract mantissa and bit-shift it in place
	r = (sr ? r : -r-1) << 1            # negative regime r<0 : positive regime r>=0, "<<1" is the same as "*2"

    # sign | regime+exponent | mantissa
	return reinterpret(Float32,(ui & 0x8000) << 16 | (r+e+127)<<23 | m)
end