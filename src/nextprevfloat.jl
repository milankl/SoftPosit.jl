nextfloat(p::Posit8) = reinterpret(Posit8,reinterpret(UInt8,p)+one(UInt8))
nextfloat(p::Posit16) = reinterpret(Posit16,reinterpret(UInt16,p)+one(UInt16))
nextfloat(p::Posit32) = reinterpret(Posit32,reinterpret(UInt32,p)+one(UInt32))

prevfloat(p::Posit8) = reinterpret(Posit8,reinterpret(UInt8,p)-one(UInt8))
prevfloat(p::Posit16) = reinterpret(Posit16,reinterpret(UInt16,p)-one(UInt16))
prevfloat(p::Posit32) = reinterpret(Posit32,reinterpret(UInt32,p)-one(UInt32))

# this formulation causes a no method matching error nextfloat(::Posit8_2,::Int64) which I don't understand
# nextfloat(p::Type{T}) where {T<:Union{PositX1,PositX2}} = reinterpret(T,reinterpret(UInt32,p)+reinterpret(UInt32,floatmin(T)))
# prevfloat(p::Type{T}) where {T<:Union{PositX1,PositX2}} = reinterpret(T,reinterpret(UInt32,p)-reinterpret(UInt32,floatmin(T)))

nextfloat(p::Posit8_1) = reinterpret(Posit8_1,reinterpret(UInt32,p)+reinterpret(UInt32,floatmin(Posit8_1)))
nextfloat(p::Posit16_1) = reinterpret(Posit16_1,reinterpret(UInt32,p)+reinterpret(UInt32,floatmin(Posit16_1)))
nextfloat(p::Posit24_1) = reinterpret(Posit24_1,reinterpret(UInt32,p)+reinterpret(UInt32,floatmin(Posit24_1)))

nextfloat(p::Posit8_2) = reinterpret(Posit8_2,reinterpret(UInt32,p)+reinterpret(UInt32,floatmin(Posit8_2)))
nextfloat(p::Posit16_2) = reinterpret(Posit16_2,reinterpret(UInt32,p)+reinterpret(UInt32,floatmin(Posit16_2)))
nextfloat(p::Posit24_2) = reinterpret(Posit24_2,reinterpret(UInt32,p)+reinterpret(UInt32,floatmin(Posit24_2)))

prevfloat(p::Posit8_1) = reinterpret(Posit8_1,reinterpret(UInt32,p)-reinterpret(UInt32,floatmin(Posit8_1)))
prevfloat(p::Posit16_1) = reinterpret(Posit16_1,reinterpret(UInt32,p)-reinterpret(UInt32,floatmin(Posit16_1)))
prevfloat(p::Posit24_1) = reinterpret(Posit24_1,reinterpret(UInt32,p)-reinterpret(UInt32,floatmin(Posit24_1)))

prevfloat(p::Posit8_2) = reinterpret(Posit8_2,reinterpret(UInt32,p)-reinterpret(UInt32,floatmin(Posit8_2)))
prevfloat(p::Posit16_2) = reinterpret(Posit16_2,reinterpret(UInt32,p)-reinterpret(UInt32,floatmin(Posit16_2)))
prevfloat(p::Posit24_2) = reinterpret(Posit24_2,reinterpret(UInt32,p)-reinterpret(UInt32,floatmin(Posit24_2)))
