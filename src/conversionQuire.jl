# conversion from Quire to Posit standard types
Posit8(x::Quire8) = ccall((:q8_to_p8, SoftPositPath), Posit8, (Quire8,),x)
Posit16(x::Quire16) = ccall((:q16_to_p16, SoftPositPath), Posit16, (Quire16,),x)
Posit32(x::Quire32) = ccall((:q32_to_p32, SoftPositPath), Posit32, (Quire32,),x)

# not yet in the C library ...
# Posit8_1(x::Quire8_1) = ccall((:qX1_to_pX1, SoftPositPath), Posit8_1, (Quire8_1,Int64),x,8)
# Posit16_1(x::Quire16_1) = ccall((:qX1_to_pX1, SoftPositPath), Posit16_1, (Quire16_1,Int64),x,16)
# Posit24_1(x::Quire24_1) = ccall((:qX1_to_pX1, SoftPositPath), Posit24_1, (Quire24_1,Int64),x,24)

# Posit8_2(x::Quire8_2) = ccall((:qX2_to_pX2, SoftPositPath), Posit8_2, (Quire8_2,Int64),x,8)
# Posit16_2(x::Quire16_2) = ccall((:qX2_to_pX2, SoftPositPath), Posit16_2, (Quire16_2,Int64),x,16)
# Posit24_2(x::Quire24_2) = ccall((:qX2_to_pX2, SoftPositPath), Posit24_2, (Quire24_2,Int64),x,24)

# to Floats
Float64(q::Quire8) = Float64(Posit8(q))
Float64(q::Quire16) = Float64(Posit16(q))
Float64(q::Quire32) = Float64(Posit32(q))

Float32(q::Quire8) = Float32(Posit8(q))
Float32(q::Quire16) = Float32(Posit16(q))
Float32(q::Quire32) = Float32(Posit32(q))

Float16(q::Quire8) = Float16(Posit8(q))
Float16(q::Quire16) = Float16(Posit16(q))
Float16(q::Quire32) = Float16(Posit32(q))

# from Hexadecimal
Quire8(x::UInt32) = reinterpret(Quire8,x)
Quire16(x::UInt128) = reinterpret(Quire16,x)

# Well, UInt512 doesn't exist.
# Quire32(x::UInt512) = reinterpret(Quire32,x)
