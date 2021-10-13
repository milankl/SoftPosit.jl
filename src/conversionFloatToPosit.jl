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

	sign = ((ui & 0x8000_0000) >> 16) % UInt16
	e = ((ui & 0x7f80_0000) >> 23) - 127    # exponent without the exponent bias 127	
    abs_e = abs(e)							# exponent without sign
	e_odd = (abs_e & 1) % UInt16			# exponent odd = 3,5,...?
	signbit_e = signbit(e)					# sign of exponent 0: >=1; 1: <1

	n_regimebits = (abs_e >> 1) + 1			# number of regime bits
	regime = (reinterpret(Int16,0x8000 >> signbit_e) >> n_regimebits) & 0x7fff
	exponent = e_odd << (13-n_regimebits)

	# mantissa round to zero
	mantissa = ((ui & 0x007f_ffff) >> (10+n_regimebits)) % UInt16

	# bs = bitstring(Posit16(x),:split)
	# return (n_regimebits, bitstring(regime | exponent | mantissa), bs)
	p16 = sign | regime | exponent | mantissa
	return reinterpret(Posit16,p16)
end
