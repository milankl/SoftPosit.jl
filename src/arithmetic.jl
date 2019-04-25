# Add
+(x::Posit8,y::Posit8) = ccall((:p8_add, SoftPositPath), Posit8, (Posit8,Posit8),x,y)
+(x::Posit16,y::Posit16) = ccall((:p16_add, SoftPositPath), Posit16, (Posit16,Posit16),x,y)
+(x::Posit32,y::Posit32) = ccall((:p32_add, SoftPositPath), Posit32, (Posit32,Posit32),x,y)

+(x::Posit8_2,y::Posit8_2) = ccall((:pX2_add, SoftPositPath), Posit8_2, (Posit8_2,Posit8_2,Int64),x,y,8)
+(x::Posit16_2,y::Posit16_2) = ccall((:pX2_add, SoftPositPath), Posit16_2, (Posit16_2,Posit16_2,Int64),x,y,16)
+(x::Posit24_2,y::Posit24_2) = ccall((:pX2_add, SoftPositPath), Posit24_2, (Posit24_2,Posit24_2,Int64),x,y,24)

# Subtract
-(x::Posit8,y::Posit8) = ccall((:p8_sub, SoftPositPath), Posit8, (Posit8,Posit8),x,y)
-(x::Posit16,y::Posit16) = ccall((:p16_sub, SoftPositPath), Posit16, (Posit16,Posit16),x,y)
-(x::Posit32,y::Posit32) = ccall((:p32_sub, SoftPositPath), Posit32, (Posit32,Posit32),x,y)

-(x::Posit8_2,y::Posit8_2) = ccall((:pX2_sub, SoftPositPath), Posit8_2, (Posit8_2,Posit8_2,Int64),x,y,8)
-(x::Posit16_2,y::Posit16_2) = ccall((:pX2_sub, SoftPositPath), Posit16_2, (Posit16_2,Posit16_2,Int64),x,y,16)
-(x::Posit24_2,y::Posit24_2) = ccall((:pX2_sub, SoftPositPath), Posit24_2, (Posit24_2,Posit24_2,Int64),x,y,24)

# Multiply
*(x::Posit8,y::Posit8) = ccall((:p8_mul, SoftPositPath), Posit8, (Posit8,Posit8),x,y)
*(x::Posit16,y::Posit16) = ccall((:p16_mul, SoftPositPath), Posit16, (Posit16,Posit16),x,y)
*(x::Posit32,y::Posit32) = ccall((:p32_mul, SoftPositPath), Posit32, (Posit32,Posit32),x,y)

*(x::Posit8_2,y::Posit8_2) = ccall((:pX2_mul, SoftPositPath), Posit8_2, (Posit8_2,Posit8_2,Int64),x,y,8)
*(x::Posit16_2,y::Posit16_2) = ccall((:pX2_mul, SoftPositPath), Posit16_2, (Posit16_2,Posit16_2,Int64),x,y,16)
*(x::Posit24_2,y::Posit24_2) = ccall((:pX2_mul, SoftPositPath), Posit24_2, (Posit24_2,Posit24_2,Int64),x,y,24)

# Divide
/(x::Posit8,y::Posit8) = ccall((:p8_div, SoftPositPath), Posit8, (Posit8,Posit8),x,y)
/(x::Posit16,y::Posit16) = ccall((:p16_div, SoftPositPath), Posit16, (Posit16,Posit16),x,y)
/(x::Posit32,y::Posit32) = ccall((:p32_div, SoftPositPath), Posit32, (Posit32,Posit32),x,y)

/(x::Posit8_2,y::Posit8_2) = ccall((:pX2_div, SoftPositPath), Posit8_2, (Posit8_2,Posit8_2,Int64),x,y,8)
/(x::Posit16_2,y::Posit16_2) = ccall((:pX2_div, SoftPositPath), Posit16_2, (Posit16_2,Posit16_2,Int64),x,y,16)
/(x::Posit24_2,y::Posit24_2) = ccall((:pX2_div, SoftPositPath), Posit24_2, (Posit24_2,Posit24_2,Int64),x,y,24)

# Square root
sqrt(x::Posit8) = ccall((:p8_sqrt, SoftPositPath), Posit8, (Posit8,),x)
sqrt(x::Posit16) = ccall((:p16_sqrt, SoftPositPath), Posit16, (Posit16,),x)
sqrt(x::Posit32) = ccall((:p32_sqrt, SoftPositPath), Posit32, (Posit32,),x)

sqrt(x::Posit8_2) = ccall((:pX2_sqrt, SoftPositPath), Posit8_2, (Posit8_2,Int64),x,8)
sqrt(x::Posit16_2) = ccall((:pX2_sqrt, SoftPositPath), Posit16_2, (Posit16_2,Int64),x,16)
sqrt(x::Posit24_2) = ccall((:pX2_sqrt, SoftPositPath), Posit24_2, (Posit24_2,Int64),x,24)

# Unary minus (multiply by posit -1)
-(x::Posit8) = x*Posit8(0xc0)
-(x::Posit16) = x*Posit16(0xc000)
-(x::Posit32) = x*Posit32(0xc0000000)

-(x::Posit8_2) = x*Posit8_2(0xc0)
-(x::Posit16_2) = x*Posit16_2(0xc000)
-(x::Posit24_2) = x*Posit24_2(0xc0000000)

# literal zero and one (via reinterpretation of hexadecimal)
zero(::Posit8) = Posit8(0x00)
zero(::Posit16) = Posit16(0x0000)
zero(::Posit32) = Posit32(0x00000000)

one(::Posit8) = Posit8(0x40)
one(::Posit16) = Posit16(0x4000)
one(::Posit32) = Posit32(0x40000000)

# for Posit_2 - internally stored as 32bit
zero(::Posit8_2) = Posit8_2(0x00)
zero(::Posit16_2) = Posit16_2(0x0000)
zero(::Posit24_2) = Posit32_2(0x00000000)

one(::Posit8_2) = Posit8_2(0x40)
one(::Posit16_2) = Posit16_2(0x4000)
one(::Posit24_2) = Posit24_2(0x40000000)

# comparison
==(x::Posit8,y::Posit8) = ccall((:p8_eq, SoftPositPath), Bool, (Posit8,Posit8),x,y)
==(x::Posit16,y::Posit16) = ccall((:p16_eq, SoftPositPath), Bool, (Posit16,Posit16),x,y)
==(x::Posit32,y::Posit32) = ccall((:p32_eq, SoftPositPath), Bool, (Posit32,Posit32),x,y)

<(x::Posit8,y::Posit8) = ccall((:p8_lt, SoftPositPath), Bool, (Posit8,Posit8),x,y)
<(x::Posit16,y::Posit16) = ccall((:p16_lt, SoftPositPath), Bool, (Posit16,Posit16),x,y)
<(x::Posit32,y::Posit32) = ccall((:p32_lt, SoftPositPath), Bool, (Posit32,Posit32),x,y)

<=(x::Posit8,y::Posit8) = ccall((:p8_le, SoftPositPath), Bool, (Posit8,Posit8),x,y)
<=(x::Posit16,y::Posit16) = ccall((:p16_le, SoftPositPath), Bool, (Posit16,Posit16),x,y)
<=(x::Posit32,y::Posit32) = ccall((:p32_le, SoftPositPath), Bool, (Posit32,Posit32),x,y)
