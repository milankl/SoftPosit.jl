# == for posits only true if and only if types and bits match exactly (===, egality)
Base.:(==)(x::AbstractPosit,y::AbstractPosit) = x === y
Base.isnan(x::AbstractPosit) = x == notareal(x)         # use isnan for "is NaR?" check
Base.isfinite(x::AbstractPosit) = ~isnan(x)             # finite if not NaR
Base.iszero(x::AbstractPosit) = x == zero(x)

# COMPARISONS via two's complement (- of uints)
for op in (:(<), :(<=))
    @eval begin
        function Base.$op(x::T,y::T) where {T<:AbstractPosit}
            return $op(-reinterpret(Base.uinttype(T),x),-reinterpret(Base.uinttype(T),y))
        end
    end
end