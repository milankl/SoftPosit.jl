# initialise
Quire8() = reinterpret(Quire8,0x0000_0000)
Quire16() = reinterpret(Quire16,0x0000_0000_0000_0000_0000_0000_0000_0000)
# Quire32() = reinterpret(Quire32,0x0000_0000_0000_0000_0000_0000_0000_0000
#                                 0x0000_0000_0000_0000_0000_0000_0000_0000
#                                 0x0000_0000_0000_0000_0000_0000_0000_0000
#                                 0x0000_0000_0000_0000_0000_0000_0000_0000)

# set quire to zero
zero!(q::Quire8) = ccall((:q8_clr, SoftPositPath), Quire8, (Quire8,),q)
zero!(q::Quire16) = ccall((:q16_clr, SoftPositPath), Quire16, (Quire16,),q)
zero!(q::Quire32) = ccall((:q32_clr, SoftPositPath), Quire32, (Quire32,),q)

# Fused multiply-add q+b*c
fma(q::Quire8,b::Posit8,c::Posit8) = ccall((:q8_fdp_add, SoftPositPath), Quire8, (Quire8,Posit8,Posit8),q,b,c)
fma(q::Quire16,b::Posit16,c::Posit16) = ccall((:q16_fdp_add, SoftPositPath), Quire16, (Quire16,Posit16,Posit16),q,b,c)
fma(q::Quire32,b::Posit32,c::Posit32) = ccall((:q32_fdp_add, SoftPositPath), Quire32, (Quire32,Posit32,Posit32),q,b,c)

# Fused multiply-sub q-b*c
fms(q::Quire8,a::Posit8,b::Posit8) = ccall((:q8_fdp_sub, SoftPositPath), Quire8, (Quire8,Posit8,Posit8),q,a,b)
fms(q::Quire16,a::Posit16,b::Posit16) = ccall((:q16_fdp_sub, SoftPositPath), Quire16, (Quire16,Posit16,Posit16),q,a,b)
fms(q::Quire32,a::Posit32,b::Posit32) = ccall((:q32_fdp_sub, SoftPositPath), Quire32, (Quire32,Posit32,Posit32),q,a,b)
