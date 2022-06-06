abstract type AbstractPosit <: AbstractFloat end
abstract type AbstractQuire <: AbstractFloat end

# 2022 standard formats, always 2 exponent bits
primitive type Posit8 <: AbstractPosit 8 end        # Posit(8,2)
primitive type Posit16 <: AbstractPosit 16 end      # Posit(16,2)
primitive type Posit32 <: AbstractPosit 32 end      # Posit(32,2)

# Also define Posit(16,1)
primitive type Posit16_1 <: AbstractPosit 16 end

# Quires
primitive type Quire8 <: AbstractQuire 128 end
primitive type Quire16 <: AbstractQuire 256 end
primitive type Quire32 <: AbstractQuire 512 end

# Type unions
Float16or32 = Union{Float16,Float32}
PositAll16 = Union{Posit16,Posit16_1}               # with 1 or 2 exponent bits