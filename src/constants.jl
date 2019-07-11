# 8bit Posits
one(::Type{T}) where {T<:PositAll8} = T(0x40)
minusone(::Type{T}) where {T<:PositAll8} = T(0xc0)
zero(::Type{T}) where {T<:PositAll8} = T(0x00)
floatmax(::Type{T}) where {T<:PositAll8} = T(0x7f)
floatmin(::Type{T}) where {T<:PositAll8} = T(0x01)

# 16bit Posits
one(::Type{T}) where {T<:PositAll16} = T(0x4000)
minusone(::Type{T}) where {T<:PositAll16} = T(0xc000)
zero(::Type{T}) where {T<:PositAll16} = T(0x0000)
floatmax(::Type{T}) where {T<:PositAll16} = T(0x7fff)
floatmin(::Type{T}) where {T<:PositAll16} = T(0x0001)

# 24bit Posits
one(::Type{T}) where {T<:PositAll24} = T(0x4000_0000)
minusone(::Type{T}) where {T<:PositAll24} = T(0xc000_0000)
zero(::Type{T}) where {T<:PositAll24} = T(0x0000_0000)
floatmax(::Type{T}) where {T<:PositAll24} = T(0x7fff_ff00)
floatmin(::Type{T}) where {T<:PositAll24} = T(0x0000_0100)

# 32bit Posits
one(::Type{Posit32}) = Posit32(0x4000_0000)
minusone(::Type{Posit32}) = Posit32(0xc000_0000)
zero(::Type{Posit32}) = Posit32(0x0000_0000)
floatmax(::Type{Posit32}) = Posit32(0x7fff_ffff)
floatmin(::Type{Posit32}) = Posit32(0x0000_0001)

# -(x::T) where {T<:PositAll8} = x*minusone(T)
# -(x::T) where {T<:PositAll16} = x*minusone(T)
# -(x::T) where {T<:PositAll24} = x*minusone(T)
# -(x::Posit32) = x*minusone(Posit32)

function -(x::T) where {T<:PositAll8}
    if x == zero(T) || x == notareal(T) # don't change sign for 0 and NaR
        return x
    else    # subtracting from 0x00 (two's complement def for neg)
        return T(0x00 - UInt8(x))
    end
end

function -(x::T) where {T<:PositAll16}
    if x == zero(T) || x == notareal(T) # don't change sign for 0 and NaR
        return x
    else    # subtracting from 0x0000 (two's complement def for neg)
        return T(0x0000 - UInt16(x))
    end
end

function -(x::T) where {T<:Union{Posit32,PositAll24}}
    if x == zero(T) || x == notareal(T) # don't change sign for 0 and NaR
        return x
    else    # subtracting from 0x0000 (two's complement def for neg)
        return T(0x0000_0000 - UInt32(x))
    end
end

# generalize also for objects of the type AbstractPosit
minusone(p::AbstractPosit) = minusone(typeof(p))

notareal(::Type{T}) where {T<:PositAll8} = T(0x80)
notareal(::Type{T}) where {T<:PositAll16} = T(0x8000)
notareal(::Type{T}) where {T<:PositAll24} = T(0x8000_0000)
notareal(::Type{Posit32}) = Posit32(0x8000_0000)
notareal(p::AbstractPosit) = notareal(typeof(p))

signbit(p::Posit8) = signbit(reinterpret(Int8,p))
signbit(p::Posit16) = signbit(reinterpret(Int16,p))
signbit(p::Posit32) = signbit(reinterpret(Int32,p))
signbit(p::T) where {T<:Union{PositX1,PositX2}} = signbit(reinterpret(Int32,p))

isfinite(p::T) where {T<:AbstractPosit} = p != notareal(T)

function sign(p::T) where {T <: AbstractPosit}
    if signbit(p)       # negative and infinity case
        if isfinite(p)  # negative
            return minusone(T)
        else            # infinity
            return zero(T)
        end
    else                # positive and zero case
        if iszero(p)    # zero
            return zero(T)
        else            # positive
            return one(T)
        end
    end
end
