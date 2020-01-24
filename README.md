[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://img.shields.io/badge/repo_status-active-brightgreen?style=flat-square)](https://www.repostatus.org/#active)
[![Travis](https://img.shields.io/travis/com/milankl/SoftPosit.jl?label=Linux%20%26%20osx&logo=travis&style=flat-square)](https://travis-ci.com/milankl/SoftPosit.jl)
[![AppVeyor](https://img.shields.io/appveyor/ci/milankl/Softposit-jl?label=Windows&logo=appveyor&logoColor=white&style=flat-square)](https://ci.appveyor.com/project/milankl/SoftPosit-jl)
[![Cirrus CI](https://img.shields.io/cirrus/github/milankl/Softposit.jl?label=FreeBSD&logo=cirrus-ci&logoColor=white&style=flat-square)](https://cirrus-ci.com/github/milankl/SoftPosit.jl)

[![DOI](https://zenodo.org/badge/183233999.svg)](https://zenodo.org/badge/latestdoi/183233999)

# SoftPosit.jl

[Julia](https://julialang.org/) types for the C-based [SoftPosit](https://gitlab.com/cerlane/SoftPosit) library - a posit arithmetic emulator.

Posit numbers are an alternative to floating-point numbers. Posits extend floats by introducing regime bits, that allow for a higher precision around one, yet a wide dynamic range of representable numbers. For further information see https://posithub.org

If this library doesn't support a desired functionality or for anything else, please raise an issue.

# 8, 16 and 32bit posit formats

SoftPosit.jl emulates the following Posit number formats `Posit(n,es)`, with `n` number of bits including `es` exponent bits: Posit(8,0), Posit(16,1), Posit(32,2) as primitive types called

    Posit8, Posit16, Posit32

following the [draft standard](https://posithub.org/docs/posit_standard.pdf). Additionally, the following off-standard formats are defined as primitive types, which are internally stored as 32bit (the remaining bits are kept as zeros): Posit(8,1), Posit(8,2), Posit(16,1), Posit(16,2), Posit(24,1), and Posit(24,2) called `Posit8_1`, `Posit8_2`, `Posit16_1`, `Posit16_2`, `Posit24_1`, and `Posit24_2`.

For all the types `Posit8, Posit16, Posit32, Posit8_2, Posit16_2, Posit24_2` conversions between Integers and Floats and basic arithmetic operations `+`, `-`, `*`, `/` and `sqrt` (among others) are defined. Unfortunately, `Posit8_1, Posit16_1, Posit24_1` are not yet fully supported by the underlying C library.

To support quires, `Quire8`, `Quire16` and `Quire32` are implemented as 32 / 128 / 512bit types for fused multiply-add and fused multiply-subtract. Additional math functions like `exp`,`log`,`sin`,`cos`,`tan` are defined via conversion to `Float64` (no support yet of the C library) and therefore do not have error-free rounding.

# Examples

Conversion to and from `Float64` and computing a square root

```julia
julia> using SoftPosit
julia> p = Posit16(16.0)
Posit16(0x7000)

julia> sqrt(p)
Posit16(0x6000)

julia> Float64(sqrt(p))
4.0
```

for a comprehensive notebook covering (almost) all the functionality of SoftPosit.jl please read [softposit_examples.ipynb](https://github.com/milankl/SoftPosit.jl/blob/master/docs/softposit_examples.ipynb)


# Installation

In the package manager do

```julia
julia>] add SoftPosit
```

and then simply `using SoftPosit` which enables all of the functionality.
