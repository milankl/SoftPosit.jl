exp(p::T) where {T<:AbstractPosit} = T(exp(Float64(p)))
log(p::T) where {T<:AbstractPosit} = T(log(Float64(p)))

sin(p::T) where {T<:AbstractPosit} = T(sin(Float64(p)))
cos(p::T) where {T<:AbstractPosit} = T(cos(Float64(p)))
tan(p::T) where {T<:AbstractPosit} = T(tan(Float64(p)))
