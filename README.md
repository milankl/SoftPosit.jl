# SoftPosit.jl
[![CI](https://github.com/milankl/SoftPosit.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/milankl/SoftPosit.jl/actions/workflows/CI.yml)
[![DOI](https://zenodo.org/badge/183233999.svg)](https://zenodo.org/badge/latestdoi/183233999)

[Julia](https://julialang.org/) types for the C-based [SoftPosit](https://gitlab.com/cerlane/SoftPosit) library - a posit arithmetic emulator.

Posit numbers are an alternative to floating-point numbers. Posits extend floats by introducing regime bits
that allow for a higher precision around one, yet a wide dynamic range of representable numbers.
For further information see [posithub.org](https://posithub.org).

If this library doesn't support a desired functionality or for anything else, please
[raise an issue](https://github.com/milankl/SoftPosit.jl/issues).

Note: This library is not yet conform with the [2022 Standard for Posit Arithmetic](https://posithub.org/docs/posit_standard-2.pdf).

# Installation

In the Julia REPL do

```julia
julia>] add SoftPosit
```

where `]` opens the package manager. Then simply `using SoftPosit` which enables all of the functionality.

# 8, 16 and 32bit posit formats

SoftPosit.jl emulates the following Posit number formats `Posit(n,es)`, with `n` number of bits including `es` exponent bits:
Posit(8,0), Posit(16,1), Posit(32,2) as primitive types called

    Posit8, Posit16, Posit32

following the [draft standard](https://posithub.org/docs/posit_standard.pdf) although this will be changed to always 2 exponent
bits to match the [2022 standard](https://posithub.org/docs/posit_standard-2.pdf). Additionally, the following formats are defined
as primitive types, which are internally stored as 32bit (the remaining bits are kept as zeros): Posit(8,1), Posit(8,2), Posit(16,1),
Posit(16,2), Posit(24,1), and Posit(24,2) called `Posit8_1`, `Posit8_2`, `Posit16_1`, `Posit16_2`, `Posit24_1`, and `Posit24_2`.

For all the types `Posit8, Posit16, Posit32, Posit8_2, Posit16_2, Posit24_2` conversions between Integers and Floats and
basic arithmetic operations `+`, `-`, `*`, `/` and `sqrt` (among others) are defined.
Unfortunately, `Posit8_1, Posit16_1, Posit24_1` are not fully supported by the underlying C library.

To support quires, `Quire8`, `Quire16` and `Quire32` are implemented as 32 / 128 / 512bit types for fused multiply-add and
fused multiply-subtract. Additional math functions like `exp`,`log`,`sin`,`cos`,`tan` are defined via conversion to `Float64`
(no support yet of the C library) and therefore do not have error-free rounding.

# Examples

Conversion to and from `Float64` and computing a square root

```julia
julia> using SoftPosit
julia> p = Posit16(16)
Posit16(16.0)

julia> sqrt(p)
Posit16(4.0)
```
And the bitwise representation split into sign, regime, exponent and mantissa bits using `bitstring(p,:split)`

```julia
julia> bitstring(Posit32(123456.7),:split)
"0 111110 00 11100010010000001011010"
```

For a comprehensive notebook covering (almost) all the functionality of SoftPosit.jl
please read [softposit_examples.ipynb](https://github.com/milankl/SoftPosit.jl/blob/master/docs/softposit_examples.ipynb)

# Rounding mode

Following the [2022 posit standard](https://posithub.org/docs/posit_standard-2.pdf),
posits should never underflow nor overflow. Consequently, `(0,minpos/2]` and `[-minpos/2,0)`
are mapped to `±minpos`, respectively, and `[maxpos,∞)` and `(-∞,-maxpos]` to `±maxpos`.
Float ±infinity and Not-a-Number are mapped to posit Not-a-Real NaR, and NaR is mapped back to NaN.
In the current version v0.4 the implementaion of this rounding mode make a few changes that
will be resolved in upcoming releases.

- **Posit8 and Posit32**: No underflow, all numbers in [-minpos,0) are mapped to -minpos (and (0,minpos] to minpos)
- **Posit16**: Underflow occurs at minpos/4 and overflow occurs at floatmax(Float32)/4

Round to nearest, tie to even is implemented for all formats.

