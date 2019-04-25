# conversion between Posit8, Posit16 and Posit32
Posit8(x::Posit16) = ccall((:p16_to_p8, SoftPositPath), Posit8, (Posit16,),x)
Posit32(x::Posit16) = ccall((:p16_to_p32, SoftPositPath), Posit32, (Posit16,),x)
Posit8(x::Posit32) = ccall((:p32_to_p8, SoftPositPath), Posit8, (Posit32,),x)
Posit16(x::Posit32) = ccall((:p32_to_p16, SoftPositPath), Posit16, (Posit32,),x)
Posit16(x::Posit8) = ccall((:p8_to_p16, SoftPositPath), Posit16, (Posit8,),x)
Posit32(x::Posit8) = ccall((:p8_to_p32, SoftPositPath), Posit32, (Posit8,),x)

# conversion from Posit8,16,32 to PX1
Posit8_1(x::Posit8) = ccall((:p8_to_pX1, SoftPositPath), Posit8_1, (Posit8,Int64),x,8)
Posit16_1(x::Posit8) = ccall((:p8_to_pX1, SoftPositPath), Posit16_1, (Posit8,Int64),x,16)
Posit24_1(x::Posit8) = ccall((:p8_to_pX1, SoftPositPath), Posit24_1, (Posit8,Int64),x,24)

Posit8_1(x::Posit16) = ccall((:p16_to_pX1, SoftPositPath), Posit8_1, (Posit16,Int64),x,8)
Posit16_1(x::Posit16) = ccall((:p16_to_pX1, SoftPositPath), Posit16_1, (Posit16,Int64),x,16)
Posit24_1(x::Posit16) = ccall((:p16_to_pX1, SoftPositPath), Posit24_1, (Posit16,Int64),x,24)

Posit8_1(x::Posit32) = ccall((:p32_to_pX1, SoftPositPath), Posit8_1, (Posit32,Int64),x,8)
Posit16_1(x::Posit32) = ccall((:p32_to_pX1, SoftPositPath), Posit16_1, (Posit32,Int64),x,16)
Posit24_1(x::Posit32) = ccall((:p32_to_pX1, SoftPositPath), Posit24_1, (Posit32,Int64),x,24)

# conversion from Posit8,16,32 to PX2
Posit8_2(x::Posit8) = ccall((:p8_to_pX2, SoftPositPath), Posit8_2, (Posit8,Int64),x,8)
Posit16_2(x::Posit8) = ccall((:p8_to_pX2, SoftPositPath), Posit16_2, (Posit8,Int64),x,16)
Posit24_2(x::Posit8) = ccall((:p8_to_pX2, SoftPositPath), Posit24_2, (Posit8,Int64),x,24)

Posit8_2(x::Posit16) = ccall((:p16_to_pX2, SoftPositPath), Posit8_2, (Posit16,Int64),x,8)
Posit16_2(x::Posit16) = ccall((:p16_to_pX2, SoftPositPath), Posit16_2, (Posit16,Int64),x,16)
Posit24_2(x::Posit16) = ccall((:p16_to_pX2, SoftPositPath), Posit24_2, (Posit16,Int64),x,24)

Posit8_2(x::Posit32) = ccall((:p32_to_pX2, SoftPositPath), Posit8_2, (Posit32,Int64),x,8)
Posit16_2(x::Posit32) = ccall((:p32_to_pX2, SoftPositPath), Posit16_2, (Posit32,Int64),x,16)
Posit24_2(x::Posit32) = ccall((:p32_to_pX2, SoftPositPath), Posit24_2, (Posit32,Int64),x,24)

# conversion from PX1 to Posit8,16,32
Posit8(x::Posit8_1) = ccall((:pX1_to_p8, SoftPositPath), Posit8, (Posit8_1,Int64),x,8)
Posit8(x::Posit16_1) = ccall((:pX1_to_p8, SoftPositPath), Posit8, (Posit16_1,Int64),x,16)
Posit8(x::Posit24_1) = ccall((:pX1_to_p8, SoftPositPath), Posit8, (Posit24_1,Int64),x,24)

Posit16(x::Posit8_1) = ccall((:pX1_to_p16, SoftPositPath), Posit16, (Posit8_1,Int64),x,8)
Posit16(x::Posit16_1) = ccall((:pX1_to_p16, SoftPositPath), Posit16, (Posit16_1,Int64),x,16)
Posit16(x::Posit24_1) = ccall((:pX1_to_p16, SoftPositPath), Posit16, (Posit24_1,Int64),x,24)

Posit32(x::Posit8_1) = ccall((:pX1_to_p32, SoftPositPath), Posit32, (Posit8_1,Int64),x,8)
Posit32(x::Posit16_1) = ccall((:pX1_to_p32, SoftPositPath), Posit32, (Posit16_1,Int64),x,16)
Posit32(x::Posit24_1) = ccall((:pX1_to_p32, SoftPositPath), Posit32, (Posit24_1,Int64),x,24)

# conversion from PX2 to Posit8,16,32
Posit8(x::Posit8_2) = ccall((:pX2_to_p8, SoftPositPath), Posit8, (Posit8_2,Int64),x,8)
Posit8(x::Posit16_2) = ccall((:pX2_to_p8, SoftPositPath), Posit8, (Posit16_2,Int64),x,16)
Posit8(x::Posit24_2) = ccall((:pX2_to_p8, SoftPositPath), Posit8, (Posit24_2,Int64),x,24)

Posit16(x::Posit8_2) = ccall((:pX2_to_p16, SoftPositPath), Posit16, (Posit8_2,Int64),x,8)
Posit16(x::Posit16_2) = ccall((:pX2_to_p16, SoftPositPath), Posit16, (Posit16_2,Int64),x,16)
Posit16(x::Posit24_2) = ccall((:pX2_to_p16, SoftPositPath), Posit16, (Posit24_2,Int64),x,24)

Posit32(x::Posit8_2) = ccall((:pX2_to_p32, SoftPositPath), Posit32, (Posit8_2,Int64),x,8)
Posit32(x::Posit16_2) = ccall((:pX2_to_p32, SoftPositPath), Posit32, (Posit16_2,Int64),x,16)
Posit32(x::Posit24_2) = ccall((:pX2_to_p32, SoftPositPath), Posit32, (Posit24_2,Int64),x,24)

# conversion between PX1 and PX2
Posit8_1(x::Posit8_2) = ccall((:pX2_to_pX1, SoftPositPath), Posit8_1, (Posit8_2,Int64),x,8)
Posit8_2(x::Posit8_1) = ccall((:pX1_to_pX2, SoftPositPath), Posit8_2, (Posit8_1,Int64),x,8)

Posit16_1(x::Posit16_2) = ccall((:pX2_to_pX1, SoftPositPath), Posit16_1, (Posit16_2,Int64),x,16)
Posit16_2(x::Posit16_1) = ccall((:pX1_to_pX2, SoftPositPath), Posit16_2, (Posit16_1,Int64),x,16)

Posit24_1(x::Posit24_2) = ccall((:pX2_to_pX1, SoftPositPath), Posit24_1, (Posit24_2,Int64),x,24)
Posit24_2(x::Posit24_1) = ccall((:pX1_to_pX2, SoftPositPath), Posit24_2, (Posit24_1,Int64),x,24)
