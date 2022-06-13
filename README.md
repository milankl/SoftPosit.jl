# SoftPosit.jl
[![CI](https://github.com/milankl/SoftPosit.jl/actions/workflows/CI.yml/badge.svg)](https://github.com/milankl/SoftPosit.jl/actions/workflows/CI.yml)
[![DOI](https://zenodo.org/badge/183233999.svg)](https://zenodo.org/badge/latestdoi/183233999)

A pure Julia implementation for posit arithmetic. Posit numbers are an alternative to floating-point numbers.
Posits extend floats by introducing regime bits that allow for a higher precision around one, yet a wide
dynamic range of representable numbers. For further information see [posithub.org](https://posithub.org).

v0.5 respects the [2022 Standard for Posit Arithmetic](https://posithub.org/docs/posit_standard-2.pdf) but drops
quire support. v0.4 implements the previous standard, has quire support but depends on the C implementation of
[SoftPosit](https://gitlab.com/cerlane/SoftPosit).

If this library doesn't support a desired functionality or for anything else, please
[raise an issue](https://github.com/milankl/SoftPosit.jl/issues).

# Installation

In the Julia REPL do

```julia
julia>] add SoftPosit
```

where `]` opens the package manager. Then simply `using SoftPosit` which enables all of the functionality.

# 8, 16 and 32bit posit formats

SoftPosit.jl emulates the following Posit number formats `Posit(n,es)`, with `n` number of bits including `es` exponent bits:
Posit(8,2), Posit(16,2) and Posit(32,2) called

    Posit8, Posit16, Posit32

as well as the off-standard format Posit(16,1) called `Posit16_1` as part of the previous posit arithmetic
[draft standard](https://posithub.org/docs/posit_standard.pdf).

For all the formats conversions between integers and floats and basic arithmetic operations
`+`, `-`, `*`, `/` and `sqrt` (among others) are defined.

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

For an (outdated) comprehensive notebook covering (almost) all the functionality of SoftPosit.jl
please read [softposit_examples.ipynb](https://github.com/milankl/SoftPosit.jl/blob/master/docs/softposit_examples.ipynb)

# Rounding mode

Following the [2022 posit standard](https://posithub.org/docs/posit_standard-2.pdf),
posits should never underflow nor overflow. This is in v0.5 generally respected, but there are some
caveats: Posits currently do underflow below about `4*floatmin` of the float format you are converting from.
In practice this is of little importance as even `floatmin(::PositN)^2` is larger than that
```julia
julia> floatmin(Posit16)
Posit16(1.3877788e-17)

julia> floatmin(Posit16)*floatmin(Posit16)
Posit16(1.3877788e-17)
```
and similar for other posit formats.
So in Posit16 arithmetic we have `1e-17*1e-17 = 1e-17` (no underflow) and `1e17*1e17 = 1e17` (no overflow).

