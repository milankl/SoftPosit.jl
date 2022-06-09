# 8bit Posits
Base.one(::Type{Posit8}) = reinterpret(Posit8,0x40)
minusone(::Type{Posit8}) = reinterpret(Posit8,0xc0)
Base.zero(::Type{Posit8}) = reinterpret(Posit8,0x00)
Base.floatmax(::Type{Posit8}) = reinterpret(Posit8,0x7f)    # use floatmax for maxpos
Base.floatmin(::Type{Posit8}) = reinterpret(Posit8,0x01)    # use floatmin for minpos
Base.exponent_bits(::Type{Posit8}) = 2
Base.exponent_mask(::Type{Posit8}) = 0x01
Base.sign_mask(::Type{Posit8}) = 0x80
bitsize(::Type{Posit8}) = 8

# 16bit Posits, 1 or 2 exponent bits
Base.one(::Type{T}) where {T<:PositAll16} = reinterpret(T,0x4000)
minusone(::Type{T}) where {T<:PositAll16} = reinterpret(T,0xc000)
Base.zero(::Type{T}) where {T<:PositAll16} = reinterpret(T,0x0000)
Base.floatmax(::Type{T}) where {T<:PositAll16} = reinterpret(T,0x7fff)
Base.floatmin(::Type{T}) where {T<:PositAll16} = reinterpret(T,0x0001)
Base.exponent_bits(::Type{Posit16}) = 2
Base.exponent_bits(::Type{Posit16_1}) = 1
Base.exponent_mask(::Type{Posit16}) = 0x0003
Base.exponent_mask(::Type{Posit16_1}) = 0x0001
Base.sign_mask(::Type{T}) where {T<:PositAll16} = 0x8000
bitsize(::Type{T}) where {T<:PositAll16} = 16

# 32bit Posits
Base.one(::Type{Posit32}) = reinterpret(Posit32,0x4000_0000)
minusone(::Type{Posit32}) = reinterpret(Posit32,0xc000_0000)
Base.zero(::Type{Posit32}) = reinterpret(Posit32,0x0000_0000)
Base.floatmax(::Type{Posit32}) = reinterpret(Posit32,0x7fff_ffff)
Base.floatmin(::Type{Posit32}) = reinterpret(Posit32,0x0000_0001)
Base.exponent_bits(::Type{Posit32}) = 2
Base.exponent_mask(::Type{Posit32}) = 0x0000_0003
Base.sign_mask(::Type{Posit32}) = 0x8000_0000
bitsize(::Type{Posit32}) = 32

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

# add a nan function to pick the right nan per Float format
nan(::Type{Float16}) = NaN16
nan(::Type{Float32}) = NaN32
nan(::Type{Float64}) = NaN

# add bitsize function for uints
bitsize(::Type{UInt8}) = 8
bitsize(::Type{UInt16}) = 16
bitsize(::Type{UInt32}) = 32
bitsize(::Type{UInt64}) = 64

bitsize(::Type{Float16}) = 16
bitsize(::Type{Float32}) = 32
bitsize(::Type{Float64}) = 64

# mantissa shift function for Posit -> Float conversion, generic
function mantissa_shift(::Type{FloatN},
                        ::Type{PositN}
                        ) where {FloatN<:Base.IEEEFloat,PositN<:AbstractPosit}
    Δbitsize = 8*sizeof(FloatN) - bitsize(PositN)
    return Δbitsize - (Base.exponent_bits(FloatN)+1) + Base.exponent_bits(PositN) + 1
end

# fix to avoid recomputation, but values taken from above
mantissa_shift(::Type{Float16},::Type{Posit8}) = 5
mantissa_shift(::Type{Float32},::Type{Posit8}) = 18
mantissa_shift(::Type{Float64},::Type{Posit8}) = 47

mantissa_shift(::Type{Float32},::Type{Posit16}) = 10
mantissa_shift(::Type{Float64},::Type{Posit16}) = 39
mantissa_shift(::Type{Float32},::Type{Posit16_1}) = 9
mantissa_shift(::Type{Float64},::Type{Posit16_1}) = 38

mantissa_shift(::Type{Float64},::Type{Posit32}) = 23

