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

# conversion between Float32 and Posit16
# from Moritz Lehmann, Uni Bayreuth
function Posit16_new(x::Float32)
	ui = reinterpret(UInt32,x)
	e = ((ui & 0x7f80_0000) >> 23) - 127    # exponent without the exponent bias 127
	
    abse = abs(e)			# exponent without sign
	e_odd = abse & 1		# exponent odd = 3,5,...?

    # generate regime bits, merge regime+exponent and shift in place
	nr = (abse >> 1) + 1 + signbit(e)
	# r = ((e<0 ? 0x0002 : 0xfffe << e2) + e2) #<< (13-v-e2)

    # # rounding: add 1 after truncated position; in case of lowest numbers, saturate
	# m = (ui & 0x007f_ffff) >> 10            # mantissa	
	# m = ((m>>(v-(e<0)*(1-e2)))+(e>-28)+(e<-26)*0x3)>>1

    # # sign | regime+exponent+mantissa ("+" handles rounding overflow) | saturate
	# p16 = ((ui & 0x8000_0000) >> 16 % UInt16) | (r+m) & 0x7fff | (e>26)*0x7fff
	# return reinterpret(Posit16,p16)

	bs = bitstring(Posit16(x),:split)
	return (nr, bs)
end
