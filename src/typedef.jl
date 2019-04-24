abstract type AbstractPosit <: Real end

# Posit8 with 0 exponent bits, Posit16 with 1 and Posit32 with 2
primitive type Posit8 <: AbstractPosit 8 end
primitive type Posit16 <: AbstractPosit 16 end
primitive type Posit32 <: AbstractPosit 32 end

#TODO
# Posits with two exponent bits (always stored as 32bit)
#primitive type Posit8_2 <: AbstractPosit 32 end
#primitive type Posit16_2 <: AbstractPosit 32 end
#primitive type Posit32_2 <: AbstractPosit 32 end

# SoftPositPath
const SoftPositPath = "/home/kloewer/git/SoftPosit/build/Linux-x86_64-GCC/softposit.so"
