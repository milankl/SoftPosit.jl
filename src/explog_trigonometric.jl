exp(p::T) where {T<:AbstractPosit} = T(exp(Float64(p)))
exp2(p::T) where {T<:AbstractPosit} = T(exp2(Float64(p)))
exp10(p::T) where {T<:AbstractPosit} = T(exp10(Float64(p)))
#exp(p::T) where {T<:Complex{AbstractPosit}} = T(exp(Complex{Float64}(p)))

log(p::T) where {T<:AbstractPosit} = T(log(Float64(p)))
log2(p::T) where {T<:AbstractPosit} = T(log2(Float64(p)))
log10(p::T) where {T<:AbstractPosit} = T(log10(Float64(p)))

sin(p::T) where {T<:AbstractPosit} = T(sin(Float64(p)))
cos(p::T) where {T<:AbstractPosit} = T(cos(Float64(p)))
tan(p::T) where {T<:AbstractPosit} = T(tan(Float64(p)))
