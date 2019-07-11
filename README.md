# SoftPosit.jl

[Julia](https://julialang.org/) types for the C-based [SoftPosit](https://gitlab.com/cerlane/SoftPosit) library - a posit arithmetic emulator.

Posit numbers are an alternative to floating-point numbers. Posits extend floats by introducing regime bits, that allow for a higher precision around one, yet a wide dynamic range of representable numbers. For further information see https://posithub.org

SoftPosit.jl emulates the following Posit number formats `Posit(n,es)`, with `n` number of bits including `es` exponent bits

    Posit(8,0), Posit(16,1), Posit(32,2)
    
as primitive types called `Posit8`, `Posit16`, `Posit32` following the [draft standard](https://posithub.org/docs/posit_standard.pdf). Additionally, the following off-standard formats are defined as primitive types, which are internally stored as 32bit (the remaining bits are kept as zeros)

    Posit(8,1), Posit(8,2), Posit(16,1), Posit(16,2), Posit(24,1), Posit(24,2)
   
called `Posit8_1`, `Posit8_2`, `Posit16_1`, `Posit16_2`, `Posit24_1`, `Posit24_2`.

For all the types `Posit8, Posit16, Posit32, Posit8_2, Posit16_2, Posit24_2` conversions between Integers and Floats and basic arithmetic operations `+`, `-`, `*`, `/` and `sqrt` are defined. Unfortunately, `Posit8_1, Posit16_1, Posit24_1` are not yet fully supported by the underlying C library.

To support quires, `Quire8`, `Quire16` and `Quire32` are implemented as 32 / 128 / 512bit types for fused multiply-add and fused multiply-subtract. Additional math functions like `exp`,`log`,`sin`,`cos`,`tan` are defined via conversion to `Float64` (no support yet of the C library) and therefore do not have error-free rounding.

# Examples

Conversion to and from `Float64` and computing a square root

    julia> p = Posit16(16.0)
    Posit16(0x7000)

    julia> sqrt(p)
    Posit16(0x6000)

    julia> Float64(sqrt(p))
    4.0

for a comprehensive notebook covering all the functionality of SoftPosit.jl please read [softposit_examples.ipynb](https://github.com/milankl/SoftPosit.jl/blob/master/docs/softposit_examples.ipynb)


# Installation

In the package manager do

```julia
(v1.1) pkg> add https://www.github.com/milankl/SoftPosit.jl
```
 
and then simply `using SoftPosit` which enables all of the functionality.
