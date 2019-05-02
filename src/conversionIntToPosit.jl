# fom Integer to Posit
Posit8(x::Int64) = ccall((:i64_to_p8, SoftPositPath), Posit8, (Int64,),x)
Posit8(x::Int32) = ccall((:i32_to_p8, SoftPositPath), Posit8, (Int32,),x)

Posit16(x::Int64) = ccall((:i64_to_p16, SoftPositPath), Posit16, (Int64,),x)
Posit16(x::Int32) = ccall((:i32_to_p16, SoftPositPath), Posit16, (Int32,),x)

Posit32(x::Int64) = ccall((:i64_to_p32, SoftPositPath), Posit32, (Int64,),x)
Posit32(x::Int32) = ccall((:i32_to_p32, SoftPositPath), Posit32, (Int32,),x)

# from Int64 to Posit_1
Posit8_1(x::Int64) = ccall((:i64_to_pX1, SoftPositPath), Posit8_1, (Int64,Int64),x,8)
Posit16_1(x::Int64) = ccall((:i64_to_pX1, SoftPositPath), Posit16_1, (Int64,Int64),x,16)
Posit24_1(x::Int64) = ccall((:i64_to_pX1, SoftPositPath), Posit24_1, (Int64,Int64),x,24)

# from Int64 to Posit_2
Posit8_2(x::Int64) = ccall((:i64_to_pX2, SoftPositPath), Posit8_2, (Int64,Int64),x,8)
Posit16_2(x::Int64) = ccall((:i64_to_pX2, SoftPositPath), Posit16_2, (Int64,Int64),x,16)
Posit24_2(x::Int64) = ccall((:i64_to_pX2, SoftPositPath), Posit24_2, (Int64,Int64),x,24)

# from Int32 to Posit_1
Posit8_1(x::Int32) = ccall((:i32_to_pX1, SoftPositPath), Posit8_1, (Int32,Int64),x,8)
Posit16_1(x::Int32) = ccall((:i32_to_pX1, SoftPositPath), Posit16_1, (Int32,Int64),x,16)
Posit24_1(x::Int32) = ccall((:i32_to_pX1, SoftPositPath), Posit24_1, (Int32,Int64),x,24)

# from Int32 to Posit_2
Posit8_2(x::Int32) = ccall((:i32_to_pX2, SoftPositPath), Posit8_2, (Int32,Int64),x,8)
Posit16_2(x::Int32) = ccall((:i32_to_pX2, SoftPositPath), Posit16_2, (Int32,Int64),x,16)
Posit24_2(x::Int32) = ccall((:i32_to_pX2, SoftPositPath), Posit24_2, (Int32,Int64),x,24)

# promotion
promote_rule(::Type{Int64},::Type{Posit32}) = Posit32
promote_rule(::Type{Int32},::Type{Posit32}) = Posit32
promote_rule(::Type{Int64},::Type{Posit16}) = Posit16
promote_rule(::Type{Int32},::Type{Posit16}) = Posit16
promote_rule(::Type{Int64},::Type{Posit8}) = Posit8
promote_rule(::Type{Int32},::Type{Posit8}) = Posit8

promote_rule(::Type{Int64},::Type{Posit24_1}) = Posit32
promote_rule(::Type{Int32},::Type{Posit24_1}) = Posit32
promote_rule(::Type{Int64},::Type{Posit16_1}) = Posit16
promote_rule(::Type{Int32},::Type{Posit16_1}) = Posit16
promote_rule(::Type{Int64},::Type{Posit8_1}) = Posit8
promote_rule(::Type{Int32},::Type{Posit8_1}) = Posit8

promote_rule(::Type{Int64},::Type{Posit24_2}) = Posit32
promote_rule(::Type{Int32},::Type{Posit24_2}) = Posit32
promote_rule(::Type{Int64},::Type{Posit16_2}) = Posit16
promote_rule(::Type{Int32},::Type{Posit16_2}) = Posit16
promote_rule(::Type{Int64},::Type{Posit8_2}) = Posit8
promote_rule(::Type{Int32},::Type{Posit8_2}) = Posit8
