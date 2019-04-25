# SoftPosit.jl
Julia types for the C-based SoftPosit library - a posit arithmetic emulator.

Posit numbers are an alternative to floating-point numbers. Posits extend floats by introducing regime bits, that allow for a higher precision around one, yet a wide dynamic range of representable numbers. For further information see https://posithub.org

SoftPosit.jl emulates the following Posit number formats Posit(n,es), with n number of bits including es exponent bits

    Posit(8,0), Posit(8,1), Posit(8,2),
    Posit(16,0), Posit(16,1), Posit(16,2),
    Posit(24,1), Posit(24,2),
    Posit(32,2)
  
for conversions between Integers and Floats and basic arithmetic operations +,-,*,/,sqrt

# Examples

Conversion to and from Float64 (Float32,Float16 work too)

    julia> p = Posit16(16.0)
    Posit16(0x7000)

    julia> sqrt(p)
    Posit16(0x6000)

    julia> Float64(sqrt(p))
    4.0

or directly with hexadecimal or binary

    julia> Posit8(0b01001110)
    Posit8(0x4e)

    julia> Float64(Posit8(0x4e))
    1.4375
  
Posit bit encodings can be visualized with

    julia> bitstring(Posit32(1.23))
    "01000001110101110000101000111101"

Basic arithmetic operations are overloaded

    julia> p1,p2,p3 = Posit8(1.0),Posit8(2.0),Posit8(0.5)
    (Posit8(0x40), Posit8(0x60), Posit8(0x20))

    julia> p1+p2*p3
    Posit8(0x60)

Some comparisons are implemented as well

    julia> p1 = Posit16_2(1); p2 = Posit16_2(-1);

    julia> p1 > p2
    true

And simple linear Algebra
    
    julia> A = Posit32.(randn(5,5)); b = Posit32.(randn(5));

    julia> A*b
    5-element Array{Posit32,1}:
      Posit32(0x302705c2)   
      Posit32(0xb523cd90)   
      Posit32(0x35921aed)
      Posit32(0xadf72b9d)   
      Posit32(0x545d8cee)
  
# Requires

SoftPosit C library written by Cerlane Leong (https://gitlab.com/cerlane/SoftPosit). Please install with the julia option for shared libraries.

# Usage

src/SoftPosit.jl contains a constant SoftPositPath, set to the path of the compiled C library (where the softposit.so is located). Currently, just do an include("/path/to/SoftPosit.jl/src/SoftPosit.jl") to have the Posit types available. (Will be converted to a proper module soon).
