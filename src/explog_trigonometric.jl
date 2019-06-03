exp(p::T) where {T<:AbstractPosit} = T(exp(Float64(p)))
exp2(p::T) where {T<:AbstractPosit} = T(exp2(Float64(p)))
exp10(p::T) where {T<:AbstractPosit} = T(exp10(Float64(p)))

for P in (:Posit8, :Posit16, :Posit32, :Posit8_1, :Posit16_1, :Posit24_1,
        :Posit8_2, :Posit16_2, :Posit24_2)
        @eval begin
                sin(p::Complex{$P}) = Complex{$P}(sin(Complex{Float64}(p)))
                cos(p::Complex{$P}) = Complex{$P}(cos(Complex{Float64}(p)))

                exp(p::Complex{$P}) = cos(im*p) - im*sin(im*p)
        end
end

expm1(p::T) where {T<:AbstractPosit} = exp(p) - one(T)

log(p::T) where {T<:AbstractPosit} = T(log(Float64(p)))
log2(p::T) where {T<:AbstractPosit} = T(log2(Float64(p)))
log10(p::T) where {T<:AbstractPosit} = T(log10(Float64(p)))

log1p(p::T) where {T<:AbstractPosit} = log(p) + one(T)

sin(p::T) where {T<:AbstractPosit} = T(sin(Float64(p)))
cos(p::T) where {T<:AbstractPosit} = T(cos(Float64(p)))
tan(p::T) where {T<:AbstractPosit} = T(tan(Float64(p)))

sincos(p::AbstractPosit) = sin(p),cos(p)
