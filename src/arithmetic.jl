# Add
+(x::Posit8,y::Posit8) = ccall((:p8_add, SoftPositPath), Posit8, (Posit8,Posit8),x,y)
+(x::Posit16,y::Posit16) = ccall((:p16_add, SoftPositPath), Posit16, (Posit16,Posit16),x,y)
+(x::Posit32,y::Posit32) = ccall((:p32_add, SoftPositPath), Posit32, (Posit32,Posit32),x,y)

# Subtract
-(x::Posit8,y::Posit8) = ccall((:p8_sub, SoftPositPath), Posit8, (Posit8,Posit8),x,y)
-(x::Posit16,y::Posit16) = ccall((:p16_sub, SoftPositPath), Posit16, (Posit16,Posit16),x,y)
-(x::Posit32,y::Posit32) = ccall((:p32_sub, SoftPositPath), Posit32, (Posit32,Posit32),x,y)

# Multiply
*(x::Posit8,y::Posit8) = ccall((:p8_mul, SoftPositPath), Posit8, (Posit8,Posit8),x,y)
*(x::Posit16,y::Posit16) = ccall((:p16_mul, SoftPositPath), Posit16, (Posit16,Posit16),x,y)
*(x::Posit32,y::Posit32) = ccall((:p32_mul, SoftPositPath), Posit32, (Posit32,Posit32),x,y)

# Divide
/(x::Posit8,y::Posit8) = ccall((:p8_div, SoftPositPath), Posit8, (Posit8,Posit8),x,y)
/(x::Posit16,y::Posit16) = ccall((:p16_div, SoftPositPath), Posit16, (Posit16,Posit16),x,y)
/(x::Posit32,y::Posit32) = ccall((:p32_div, SoftPositPath), Posit32, (Posit32,Posit32),x,y)

# Square root
sqrt(x::Posit8) = ccall((:p8_sqrt, SoftPositPath), Posit8, (Posit8,),x)
sqrt(x::Posit16) = ccall((:p16_sqrt, SoftPositPath), Posit16, (Posit16,),x)
sqrt(x::Posit32) = ccall((:p32_sqrt, SoftPositPath), Posit32, (Posit32,),x)

# Unary minus (multiply by posit -1)
-(x::Posit8) = x*castP8(0xc0)
-(x::Posit16) = x*castP16(0xc000)
-(x::Posit32) = x*castP32(0xc0000000)

# literal zero and one (via reinterpretation of hexadecimal)
zero(::Posit8) = castP8(0x00)
zero(::Posit16) = castP16(0x0000)
zero(::Posit32) = castP32(0x00000000)

one(::Posit8) = castP8(0x40)
one(::Posit16) = castP16(0x4000)
one(::Posit32) = castP32(0x40000000)

# comparison
<(x::Posit8,y::Posit8) = ccall((:p8_lt, SoftPositPath), Bool, (Posit8,Posit8),x,y)
<(x::Posit16,y::Posit16) = ccall((:p16_lt, SoftPositPath), Bool, (Posit16,Posit16),x,y)
<(x::Posit32,y::Posit32) = ccall((:p32_lt, SoftPositPath), Bool, (Posit32,Posit32),x,y)

<=(x::Posit8,y::Posit8) = ccall((:p8_le, SoftPositPath), Bool, (Posit8,Posit8),x,y)
<=(x::Posit16,y::Posit16) = ccall((:p16_le, SoftPositPath), Bool, (Posit16,Posit16),x,y)
<=(x::Posit32,y::Posit32) = ccall((:p32_le, SoftPositPath), Bool, (Posit32,Posit32),x,y)
