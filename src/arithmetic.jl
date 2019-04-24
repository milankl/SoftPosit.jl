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

# Unary minus
#TODO Don't convert but cast directly
-(x::Posit8) = Posit8(-1.0)*x
-(x::Posit16) = Posit16(-1.0)*x
-(x::Posit32) = Posit32(-1.0)*x

# literal zero and one
zero(::Posit8) = Posit8(0.0)
zero(::Posit16) = Posit16(0.0)
zero(::Posit32) = Posit32(0.0)

one(::Posit8) = Posit8(1.0)
one(::Posit16) = Posit16(1.0)
one(::Posit32) = Posit32(1.0)
