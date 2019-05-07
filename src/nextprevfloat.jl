nextfloat(p::Posit8) = reinterpret(Posit8,reinterpret(UInt8,p)+one(UInt8))
nextfloat(p::Posit16) = reinterpret(Posit16,reinterpret(UInt16,p)+one(UInt16))
nextfloat(p::Posit32) = reinterpret(Posit32,reinterpret(UInt32,p)+one(UInt32))

prevfloat(p::Posit8) = reinterpret(Posit8,reinterpret(UInt8,p)-one(UInt8))
prevfloat(p::Posit16) = reinterpret(Posit16,reinterpret(UInt16,p)-one(UInt16))
prevfloat(p::Posit32) = reinterpret(Posit32,reinterpret(UInt32,p)-one(UInt32))

nextfloat(p::Type{T}) where {T<:Union{PositX1,PositX2}} = reinterpret(T,reinterpret(UInt32,p)+reinterpret(UInt32,floatmin(T)))
prevfloat(p::Type{T}) where {T<:Union{PositX1,PositX2}} = reinterpret(T,reinterpret(UInt32,p)-reinterpret(UInt32,floatmin(T)))
