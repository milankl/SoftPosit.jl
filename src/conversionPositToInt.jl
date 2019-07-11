# from Posit to Integer
Int64(x::Posit8) = ccall((:p8_to_i64, SoftPositPath), Int64, (Posit8,),x)
Int64(x::Posit16) = ccall((:p16_to_i64, SoftPositPath), Int64, (Posit16,),x)
Int64(x::Posit32) = ccall((:p32_to_i64, SoftPositPath), Int64, (Posit32,),x)

Int32(x::Posit8) = ccall((:p8_to_i32, SoftPositPath), Int32, (Posit8,),x)
Int32(x::Posit16) = ccall((:p16_to_i32, SoftPositPath), Int32, (Posit16,),x)
Int32(x::Posit32) = ccall((:p32_to_i32, SoftPositPath), Int32, (Posit32,),x)

# from Posit_1 to Integer
Int64(x::Posit8_1) = ccall((:pX1_to_i64, SoftPositPath), Int64, (Posit8_1,),x)
Int64(x::Posit16_1) = ccall((:pX1_to_i64, SoftPositPath), Int64, (Posit16_1,),x)
Int64(x::Posit24_1) = ccall((:pX1_to_i64, SoftPositPath), Int64, (Posit24_1,),x)

Int32(x::Posit8_1) = ccall((:pX1_to_i32, SoftPositPath), Int32, (Posit8_1,),x)
Int32(x::Posit16_1) = ccall((:pX1_to_i32, SoftPositPath), Int32, (Posit16_1,),x)
Int32(x::Posit24_1) = ccall((:pX1_to_i32, SoftPositPath), Int32, (Posit24_1,),x)

# from Posit_2 to Integer
Int64(x::Posit8_2) = ccall((:pX2_to_i64, SoftPositPath), Int64, (Posit8_2,),x)
Int64(x::Posit16_2) = ccall((:pX2_to_i64, SoftPositPath), Int64, (Posit16_2,),x)
Int64(x::Posit24_2) = ccall((:pX2_to_i64, SoftPositPath), Int64, (Posit24_2,),x)

Int32(x::Posit8_2) = ccall((:pX2_to_i32, SoftPositPath), Int32, (Posit8_2,),x)
Int32(x::Posit16_2) = ccall((:pX2_to_i32, SoftPositPath), Int32, (Posit16_2,),x)
Int32(x::Posit24_2) = ccall((:pX2_to_i32, SoftPositPath), Int32, (Posit24_2,),x)

# Posit to UInt - this only reinterprets the bitstring and doesn't perform and actual conversion
UInt8(x::Posit8) = reinterpret(UInt8,x)
UInt8(x::Posit8_1) = UInt8(reinterpret(UInt32,x) >> 24)
UInt8(x::Posit8_2) = UInt8(reinterpret(UInt32,x) >> 24)

UInt16(x::Posit16) = reinterpret(UInt16,x)
UInt16(x::Posit16_1) = UInt16(reinterpret(UInt32,x) >> 16)
UInt16(x::Posit16_2) = UInt16(reinterpret(UInt32,x) >> 16)

UInt32(x::Posit32) = reinterpret(UInt32,x)
UInt32(x::PositAll24) = reinterpret(UInt32,x)
