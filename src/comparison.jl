# comparison
==(x::Posit8,y::Posit8) = ccall((:p8_eq, SoftPositPath), Bool, (Posit8,Posit8),x,y)
==(x::Posit16,y::Posit16) = ccall((:p16_eq, SoftPositPath), Bool, (Posit16,Posit16),x,y)
==(x::Posit32,y::Posit32) = ccall((:p32_eq, SoftPositPath), Bool, (Posit32,Posit32),x,y)

<(x::Posit8,y::Posit8) = ccall((:p8_lt, SoftPositPath), Bool, (Posit8,Posit8),x,y)
<(x::Posit16,y::Posit16) = ccall((:p16_lt, SoftPositPath), Bool, (Posit16,Posit16),x,y)
<(x::Posit32,y::Posit32) = ccall((:p32_lt, SoftPositPath), Bool, (Posit32,Posit32),x,y)

<=(x::Posit8,y::Posit8) = ccall((:p8_le, SoftPositPath), Bool, (Posit8,Posit8),x,y)
<=(x::Posit16,y::Posit16) = ccall((:p16_le, SoftPositPath), Bool, (Posit16,Posit16),x,y)
<=(x::Posit32,y::Posit32) = ccall((:p32_le, SoftPositPath), Bool, (Posit32,Posit32),x,y)

# for Posits with 1 exponent bit
for T in (:Posit8_1, :Posit16_1, :Posit24_1)
    @eval begin
        ==(x::$T,y::$T) = ccall((:pX1_eq, SoftPositPath), Bool, ($T,$T),x,y)
        <=(x::$T,y::$T) = ccall((:pX1_le, SoftPositPath), Bool, ($T,$T),x,y)
        <(x::$T,y::$T) = ccall((:pX1_lt, SoftPositPath), Bool, ($T,$T),x,y)
    end
end

# ==(x::T,y::T) where {T<:PositX1} = ccall((:pX1_eq, SoftPositPath), Bool, (T,T),x,y)
# <=(x::T,y::T) where {T<:PositX1} = ccall((:pX1_le, SoftPositPath), Bool, (T,T),x,y)
# <(x::T,y::T) where {T<:PositX1} = ccall((:pX1_lt, SoftPositPath), Bool, (T,T),x,y)

# for Posits with 2 exponent bits
for T in (:Posit8_2, :Posit16_2, :Posit24_2)
    @eval begin
        ==(x::$T,y::$T) = ccall((:pX2_eq, SoftPositPath), Bool, ($T,$T),x,y)
        <=(x::$T,y::$T) = ccall((:pX2_le, SoftPositPath), Bool, ($T,$T),x,y)
        <(x::$T,y::$T) = ccall((:pX2_lt, SoftPositPath), Bool, ($T,$T),x,y)
    end
end
