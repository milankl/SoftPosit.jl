# NEGATION via two's complement
Base.:(-)(x::T) where {T<:AbstractPosit} = reinterpret(T,-unsigned(x))

# SIGNBIT from the corresponding Int
Base.signbit(x::AbstractPosit) = signbit(signed(x))

# SIGN redefine, not x/|x| as in Base for floats
function Base.sign(x::T) where {T<:AbstractPosit}
    iszero(x) && return zero(T)
    isnan(x) && return notareal(T)
    return signbit(x) ? minusone(T) : one(T)
end

# TWO ARGUMENT ARITHMETIC, addition, subtraction, multiplication, division via conversion
for op in (:(+), :(-), :(*), :(/), :(^))
    @eval begin
        Base.$op(x::T,y::T) where {T<:AbstractPosit} = convert(T,$op(float(x),float(y)))
    end
end

# ONE ARGUMENT ARITHMETIC, sqrt, exp, log, etc. via conversion
for op in (:sqrt, :cbrt, :log, :log2, :log10, :log1p,
            :sin, :cos, :tan, :sinpi, :cospi)
    @eval begin
        Base.$op(x::T) where {T<:AbstractPosit} = convert(T,$op(float(x)))
    end
end

for op in (:exp, :exp2, :exp10, :expm1)
    @eval begin
        function Base.$op(x::T) where {T<:AbstractPosit}
            val = $op(float(x))
            isinf(val) ? floatmax(T) : convert(T, val)
        end
    end
end

Base.sincos(x::AbstractPosit) = sin(x),cos(x)   # not in eval loop because of convert
Base.sincospi(x::AbstractPosit) = sinpi(x),cospi(x)   # not in eval loop because of convert

# complex trigonometric functions
for P in (:Posit8, :Posit16, :Posit16_1, :Posit32)
        @eval begin
                sin(x::Complex{$P}) = Complex{$P}(sin(Complex{Base.floattype($P)}(x)))
                cos(x::Complex{$P}) = Complex{$P}(cos(Complex{Base.floattype($P)}(x)))
                exp(x::Complex{$P}) = cos(im*x) - im*sin(im*x)
        end
end

# nextfloat, prevfloat have a wrap-around behaviour nextfloat(maxpos) = NaR, nextfloat(NaR) = -maxpos
# which closes the posit circle and follow the 2022 standard
Base.nextfloat(x::T) where {T<:AbstractPosit} = reinterpret(T,reinterpret(Base.uinttype(T),x)+one(Base.uinttype(T)))
Base.prevfloat(x::T) where {T<:AbstractPosit} = reinterpret(T,reinterpret(Base.uinttype(T),x)-one(Base.uinttype(T)))

# precision (taken from lookup table)
Base.eps(::Type{Posit8}) = reinterpret(Posit8,0x28)
Base.eps(::Type{Posit16}) = reinterpret(Posit16,0x0a00)
Base.eps(::Type{Posit16_1}) = reinterpret(Posit16_1,0x0100)
Base.eps(::Type{Posit32}) = reinterpret(Posit32,0x00a0_0000)
Base.eps(x::AbstractPosit) = max(x-prevfloat(x),nextfloat(x)-x)
