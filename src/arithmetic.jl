# Add
+(x::Posit8,y::Posit8) = ccall((:p8_add, SoftPositPath), Posit8, (Posit8,Posit8),x,y)
+(x::Posit16,y::Posit16) = ccall((:p16_add, SoftPositPath), Posit16, (Posit16,Posit16),x,y)
+(x::Posit32,y::Posit32) = ccall((:p32_add, SoftPositPath), Posit32, (Posit32,Posit32),x,y)

+(x::Posit8_1,y::Posit8_1) = ccall((:pX1_add, SoftPositPath), Posit8_1, (Posit8_1,Posit8_1,Int64),x,y,8)
+(x::Posit16_1,y::Posit16_1) = ccall((:pX1_add, SoftPositPath), Posit16_1, (Posit16_1,Posit16_1,Int64),x,y,16)
+(x::Posit24_1,y::Posit24_1) = ccall((:pX1_add, SoftPositPath), Posit24_1, (Posit24_1,Posit24_1,Int64),x,y,24)

+(x::Posit8_2,y::Posit8_2) = ccall((:pX2_add, SoftPositPath), Posit8_2, (Posit8_2,Posit8_2,Int64),x,y,8)
+(x::Posit16_2,y::Posit16_2) = ccall((:pX2_add, SoftPositPath), Posit16_2, (Posit16_2,Posit16_2,Int64),x,y,16)
+(x::Posit24_2,y::Posit24_2) = ccall((:pX2_add, SoftPositPath), Posit24_2, (Posit24_2,Posit24_2,Int64),x,y,24)

# Subtract
-(x::Posit8,y::Posit8) = ccall((:p8_sub, SoftPositPath), Posit8, (Posit8,Posit8),x,y)
-(x::Posit16,y::Posit16) = ccall((:p16_sub, SoftPositPath), Posit16, (Posit16,Posit16),x,y)
-(x::Posit32,y::Posit32) = ccall((:p32_sub, SoftPositPath), Posit32, (Posit32,Posit32),x,y)

-(x::Posit8_1,y::Posit8_1) = ccall((:pX1_sub, SoftPositPath), Posit8_1, (Posit8_1,Posit8_1,Int64),x,y,8)
-(x::Posit16_1,y::Posit16_1) = ccall((:pX1_sub, SoftPositPath), Posit16_1, (Posit16_1,Posit16_1,Int64),x,y,16)
-(x::Posit24_1,y::Posit24_1) = ccall((:pX1_sub, SoftPositPath), Posit24_1, (Posit24_1,Posit24_1,Int64),x,y,24)

-(x::Posit8_2,y::Posit8_2) = ccall((:pX2_sub, SoftPositPath), Posit8_2, (Posit8_2,Posit8_2,Int64),x,y,8)
-(x::Posit16_2,y::Posit16_2) = ccall((:pX2_sub, SoftPositPath), Posit16_2, (Posit16_2,Posit16_2,Int64),x,y,16)
-(x::Posit24_2,y::Posit24_2) = ccall((:pX2_sub, SoftPositPath), Posit24_2, (Posit24_2,Posit24_2,Int64),x,y,24)

# Multiply
*(x::Posit8,y::Posit8) = ccall((:p8_mul, SoftPositPath), Posit8, (Posit8,Posit8),x,y)
*(x::Posit16,y::Posit16) = ccall((:p16_mul, SoftPositPath), Posit16, (Posit16,Posit16),x,y)
*(x::Posit32,y::Posit32) = ccall((:p32_mul, SoftPositPath), Posit32, (Posit32,Posit32),x,y)

*(x::Posit8_1,y::Posit8_1) = ccall((:pX1_mul, SoftPositPath), Posit8_1, (Posit8_1,Posit8_1,Int64),x,y,8)
*(x::Posit16_1,y::Posit16_1) = ccall((:pX1_mul, SoftPositPath), Posit16_1, (Posit16_1,Posit16_1,Int64),x,y,16)
*(x::Posit24_1,y::Posit24_1) = ccall((:pX1_mul, SoftPositPath), Posit24_1, (Posit24_1,Posit24_1,Int64),x,y,24)

*(x::Posit8_2,y::Posit8_2) = ccall((:pX2_mul, SoftPositPath), Posit8_2, (Posit8_2,Posit8_2,Int64),x,y,8)
*(x::Posit16_2,y::Posit16_2) = ccall((:pX2_mul, SoftPositPath), Posit16_2, (Posit16_2,Posit16_2,Int64),x,y,16)
*(x::Posit24_2,y::Posit24_2) = ccall((:pX2_mul, SoftPositPath), Posit24_2, (Posit24_2,Posit24_2,Int64),x,y,24)

# Divide
/(x::Posit8,y::Posit8) = ccall((:p8_div, SoftPositPath), Posit8, (Posit8,Posit8),x,y)
/(x::Posit16,y::Posit16) = ccall((:p16_div, SoftPositPath), Posit16, (Posit16,Posit16),x,y)
/(x::Posit32,y::Posit32) = ccall((:p32_div, SoftPositPath), Posit32, (Posit32,Posit32),x,y)

/(x::Posit8_1,y::Posit8_1) = ccall((:pX1_div, SoftPositPath), Posit8_1, (Posit8_1,Posit8_1,Int64),x,y,8)
/(x::Posit16_1,y::Posit16_1) = ccall((:pX1_div, SoftPositPath), Posit16_1, (Posit16_1,Posit16_1,Int64),x,y,16)
/(x::Posit24_1,y::Posit24_1) = ccall((:pX1_div, SoftPositPath), Posit24_1, (Posit24_1,Posit24_1,Int64),x,y,24)

/(x::Posit8_2,y::Posit8_2) = ccall((:pX2_div, SoftPositPath), Posit8_2, (Posit8_2,Posit8_2,Int64),x,y,8)
/(x::Posit16_2,y::Posit16_2) = ccall((:pX2_div, SoftPositPath), Posit16_2, (Posit16_2,Posit16_2,Int64),x,y,16)
/(x::Posit24_2,y::Posit24_2) = ccall((:pX2_div, SoftPositPath), Posit24_2, (Posit24_2,Posit24_2,Int64),x,y,24)

# Square root
sqrt(x::Posit8) = ccall((:p8_sqrt, SoftPositPath), Posit8, (Posit8,),x)
sqrt(x::Posit16) = ccall((:p16_sqrt, SoftPositPath), Posit16, (Posit16,),x)
sqrt(x::Posit32) = ccall((:p32_sqrt, SoftPositPath), Posit32, (Posit32,),x)

sqrt(x::Posit8_1) = ccall((:pX1_sqrt, SoftPositPath), Posit8_1, (Posit8_1,Int64),x,8)
sqrt(x::Posit16_1) = ccall((:pX1_sqrt, SoftPositPath), Posit16_1, (Posit16_1,Int64),x,16)
sqrt(x::Posit24_1) = ccall((:pX1_sqrt, SoftPositPath), Posit24_1, (Posit24_1,Int64),x,24)

sqrt(x::Posit8_2) = ccall((:pX2_sqrt, SoftPositPath), Posit8_2, (Posit8_2,Int64),x,8)
sqrt(x::Posit16_2) = ccall((:pX2_sqrt, SoftPositPath), Posit16_2, (Posit16_2,Int64),x,16)
sqrt(x::Posit24_2) = ccall((:pX2_sqrt, SoftPositPath), Posit24_2, (Posit24_2,Int64),x,24)
