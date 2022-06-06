# 8bit Posits
Base.one(::Type{Posit8}) = reinterpret(Posit8,0x40)
minusone(::Type{Posit8}) = reinterpret(Posit8,0xc0)
Base.zero(::Type{Posit8}) = reinterpret(Posit8,0x00)
Base.floatmax(::Type{Posit8}) = reinterpret(Posit8,0x7f)    # use floatmax for maxpos
Base.floatmin(::Type{Posit8}) = reinterpret(Posit8,0x01)    # use floatmin for minpos

# 16bit Posits, 1 or 2 exponent bits
Base.one(::Type{T}) where {T<:PositAll16} = reinterpret(T,0x4000)
minusone(::Type{T}) where {T<:PositAll16} = reinterpret(T,0xc000)
Base.zero(::Type{T}) where {T<:PositAll16} = reinterpret(T,0x0000)
Base.floatmax(::Type{T}) where {T<:PositAll16} = reinterpret(T,0x7fff)
Base.floatmin(::Type{T}) where {T<:PositAll16} = reinterpret(T,0x0001)

# 32bit Posits
Base.one(::Type{Posit32}) = reinterpret(Posit32,0x4000_0000)
minusone(::Type{Posit32}) = reinterpret(Posit32,0xc000_0000)
Base.zero(::Type{Posit32}) = reinterpret(Posit32,0x0000_0000)
Base.floatmax(::Type{Posit32}) = reinterpret(Posit32,0x7fff_ffff)
Base.floatmin(::Type{Posit32}) = reinterpret(Posit32,0x0000_0001)

# define Not-a-Real (NaR) / complex infinity
notareal(::Type{Posit8}) = reinterpret(Posit8,0x80)
notareal(::Type{T}) where {T<:PositAll16} = reinterpret(T,0x8000)
notareal(::Type{Posit32}) = reinterpret(Posit32,0x8000_0000)

# also for instances of posit types
Base.one(x::AbstractPosit) = one(typeof(x))
minusone(x::AbstractPosit) = minusone(typeof(x))
Base.zero(x::AbstractPosit) = zero(typeof(x))
Base.floatmax(x::AbstractPosit) = floatmax(typeof(x))
Base.floatmin(x::AbstractPosit) = floatmin(typeof(x))
notareal(x::AbstractPosit) = notareal(typeof(x))
