# round to nearest ties to even
round(x::Posit8) = ccall((:p8_roundToInt, SoftPositPath), Posit8, (Posit8,),x)
round(x::Posit16) = ccall((:p16_roundToInt, SoftPositPath), Posit16, (Posit16,),x)
round(x::Posit32) = ccall((:p32_roundToInt, SoftPositPath), Posit32, (Posit32,),x)

# for Posits with 1 exponent bit
for T in (:Posit8_1, :Posit16_1, :Posit24_1)
    @eval begin
        round(x::$T) =  ccall((:pX1_roundToInt, SoftPositPath), $T, ($T,),x)
    end
end

# for Posits with 1 exponent bit
for T in (:Posit8_2, :Posit16_2, :Posit24_2)
    @eval begin
        round(x::$T) =  ccall((:pX2_roundToInt, SoftPositPath), $T, ($T,),x)
    end
end

function round(x::T, r::RoundingMode{:Down}) where {T<:AbstractPosit}
    xr = round(x)
    if xr > x
        return xr-one(T)
    else
        return xr
    end
end

function round(x::T, r::RoundingMode{:Up}) where {T<:AbstractPosit}
    xr = round(x)
    if xr < x
        return xr+one(T)
    else
        return xr
    end
end
