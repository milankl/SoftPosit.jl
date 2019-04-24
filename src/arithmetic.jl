# Add
+(x::Posit8,y::Posit8) = ccall((:p8_add, SoftPositPath), Posit8, (Posit8,Posit8),x,y)
+(x::Posit16,y::Posit16) = ccall((:p16_add, SoftPositPath), Posit16, (Posit16,Posit16),x,y)
+(x::Posit32,y::Posit32) = ccall((:p32_add, SoftPositPath), Posit32, (Posit32,Posit32),x,y)
