abstract type AbstractPosit <: AbstractFloat end
abstract type AbstractQuire <: AbstractFloat end

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

# Quires
primitive type Quire8 <: AbstractQuire 32 end
primitive type Quire16 <: AbstractQuire 128 end
primitive type Quire32 <: AbstractQuire 512 end

# primitive type Quire8_1 <: AbstractQuire 512 end
# primitive type Quire16_1 <: AbstractQuire 512 end
# primitive type Quire24_1 <: AbstractQuire 512 end
#
# primitive type Quire8_2 <: AbstractQuire 512 end
# primitive type Quire16_2 <: AbstractQuire 512 end
# primitive type Quire24_2 <: AbstractQuire 512 end

# Type unions
Float16or32 = Union{Float16,Float32}
PositAll8 = Union{Posit8,Posit8_1,Posit8_2}
PositAll16 = Union{Posit16,Posit16_1,Posit16_2}
PositAll24 = Union{Posit24_1,Posit24_2}

# off-standard types
PositX1 = Union{Posit8_1,Posit16_1,Posit24_1}
PositX2 = Union{Posit8_2,Posit16_2,Posit24_2}

# all posit types with 1,2 exponent bits
PositEx1 = Union{Posit8_1,Posit16_1,Posit16,Posit24_1}
PositEx2 = Union{Posit8_2,Posit16_2,Posit24_2,Posit32}

# Quire type unions
# QuireAll8 = Union{Quire8,Quire8_1,Quire8_2}
# QuireAll16 = Union{Quire16,Quire16_1,Quire16_2}
# QuireAll24 = Union{Quire24_1,Quire24_2}
#
# QuireX1 = Union{Quire8_1,Quire16_1,Quire24_1}
# QuireX2 = Union{Quire8_2,Quire16_2,Quire24_2}
