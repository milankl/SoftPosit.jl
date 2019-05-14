# 8bit Posits
one(::Type{T}) where {T<:PositAll8} = T(0x40)
minusone(::Type{T}) where {T<:PositAll8} = T(0xc0)
zero(::Type{T}) where {T<:PositAll8} = T(0x00)
floatmax(::Type{T}) where {T<:PositAll8} = T(0x7f)
floatmin(::Type{T}) where {T<:PositAll8} = T(0x01)
-(x::T) where {T<:PositAll8} = x*T(0xc0)

# 16bit Posits
one(::Type{T}) where {T<:PositAll16} = T(0x4000)
minusone(::Type{T}) where {T<:PositAll16} = T(0xc000)
zero(::Type{T}) where {T<:PositAll16} = T(0x0000)
floatmax(::Type{T}) where {T<:PositAll16} = T(0x7fff)
floatmin(::Type{T}) where {T<:PositAll16} = T(0x0001)
-(x::T) where {T<:PositAll16} = x*T(0xc000)

# 24bit Posits
one(::Type{T}) where {T<:PositAll24} = T(0x4000_0000)
minusone(::Type{T}) where {T<:PositAll24} = T(0xc000_0000)
zero(::Type{T}) where {T<:PositAll24} = T(0x0000_0000)
floatmax(::Type{T}) where {T<:PositAll24} = T(0x7fff_ff00)
floatmin(::Type{T}) where {T<:PositAll24} = T(0x0000_0100)
-(x::T) where {T<:PositAll24} = x*T(0xc000_0000)

# 32bit Posits
one(::Type{Posit32}) = Posit32(0x4000_0000)
minusone(::Type{Posit32}) = Posit32(0xc000_0000)
zero(::Type{Posit32}) = Posit32(0x0000_0000)
floatmax(::Type{Posit32}) = Posit32(0x7fff_ffff)
floatmin(::Type{Posit32}) = Posit32(0x0000_0001)
-(x::Posit32) = x*Posit32(0xc000_0000)

eps(::Type{Posit8}) = Posit8(0x02)
eps(::Type{Posit16}) = Posit16(0x0100)
eps(::Type{Posit32}) = Posit32(0x00a0_0000)

#TODO remove subtraction once pX1_sub is available in the C version
eps(::Type{Posit8_1}) = Posit8_1(0x41) - Posit8_1(0x40)
eps(::Type{Posit16_1}) = Posit16_1(0x4001) - Posit16_1(0x4000)
eps(::Type{Posit24_1}) = Posit24_1(0x4000_01) - Posit24_1(0x4000_00)

eps(::Type{Posit8_2}) = Posit8_2(0x2800_0000)
eps(::Type{Posit16_2}) = Posit16_2(0x0a00_0000)
eps(::Type{Posit24_2}) = Posit24_2(0x0280_0000)

notareal(::Type{T}) where {T<:PositAll8} = T(0x80)
notareal(::Type{T}) where {T<:PositAll16} = T(0x8000)
notareal(::Type{T}) where {T<:PositAll24} = T(0x8000_0000)
notareal(::Posit32) = Posit32(0x8000_0000)
notareal(p::AbstractPosit) = notareal(typeof(p))

signbit(p::Posit8) = signbit(reinterpret(Int8,p))
signbit(p::Posit16) = signbit(reinterpret(Int16,p))
signbit(p::Posit32) = signbit(reinterpret(Int32,p))

# TODO I don't get why this formulation doesn't work
# signbit(p::Type{T}) where {T<:Union{PositX1,PositX2}} = signbit(reinterpret(Int32,p))

# instead
signbit(p::Posit8_1) = signbit(reinterpret(Int32,p))
signbit(p::Posit16_1) = signbit(reinterpret(Int32,p))
signbit(p::Posit24_1) = signbit(reinterpret(Int32,p))

signbit(p::Posit8_2) = signbit(reinterpret(Int32,p))
signbit(p::Posit16_2) = signbit(reinterpret(Int32,p))
signbit(p::Posit24_2) = signbit(reinterpret(Int32,p))


isfinite(p::Type{T}) where {T<:AbstractPosit} = p != notareal(T)

function sign(p::Type{T}) where {T <: AbstractPosit}
    if signbit(p)       # negative and infinity case
        if isfinite(p)  # negative
            return minusone(T)
        else            # infinity
            return notareal(T)
        end
    else                # positive and zero case
        if iszero(p)    # zero
            return zero(T)
        else            # positive
            return one(T)
        end
    end
end
