# literal zero for initialisation
zero(::Type{Quire8}) = Quire8(0x0000_0000)
zero(::Type{Quire16}) = Quire16(0x0000_0000_0000_0000_0000_0000_0000_0000)
zero(::Type{Quire32}) = Base.zext_int(Quire32,0x0)

# literal one
one(::Type{Quire8}) = Quire8(0x00001000)
one(::Type{Quire16}) = Quire16(0x01000000000000000000000000000000)
#one(::Type{Quire32}) = Quire32(0x01000000000000000000000000000000)

# Fused multiply-add q+b*c
fma(q::Quire8,b::Posit8,c::Posit8) = ccall((:q8_fdp_add, SoftPositPath), Quire8, (Quire8,Posit8,Posit8),q,b,c)
fma(q::Quire16,b::Posit16,c::Posit16) = ccall((:q16_fdp_add, SoftPositPath), Quire16, (Quire16,Posit16,Posit16),q,b,c)
fma(q::Quire32,b::Posit32,c::Posit32) = ccall((:q32_fdp_add, SoftPositPath), Quire32, (Quire32,Posit32,Posit32),q,b,c)

# Fused multiply-sub q-b*c
fms(q::Quire8,a::Posit8,b::Posit8) = ccall((:q8_fdp_sub, SoftPositPath), Quire8, (Quire8,Posit8,Posit8),q,a,b)
fms(q::Quire16,a::Posit16,b::Posit16) = ccall((:q16_fdp_sub, SoftPositPath), Quire16, (Quire16,Posit16,Posit16),q,a,b)
fms(q::Quire32,a::Posit32,b::Posit32) = ccall((:q32_fdp_sub, SoftPositPath), Quire32, (Quire32,Posit32,Posit32),q,a,b)
