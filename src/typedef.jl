abstract type AbstractPosit <: AbstractFloat end

# Posit8 with 0 exponent bits, Posit16 with 1 and Posit32 with 2
primitive type Posit8 <: AbstractPosit 8 end
primitive type Posit16 <: AbstractPosit 16 end
primitive type Posit32 <: AbstractPosit 32 end

# Posits with one exponent bits (always stored as 32bit)
primitive type Posit8_1 <: AbstractPosit 32 end
primitive type Posit16_1 <: AbstractPosit 32 end
primitive type Posit24_1 <: AbstractPosit 32 end

# Posits with two exponent bits (always stored as 32bit)
primitive type Posit8_2 <: AbstractPosit 32 end
primitive type Posit16_2 <: AbstractPosit 32 end
primitive type Posit24_2 <: AbstractPosit 32 end

# type unions
Float16or32 = Union{Float16,Float32}
PositX1 = Union{Posit8_1,Posit16_1,Posit24_1}
PositX2 = Union{Posit8_2,Posit16_2,Posit24_2}
