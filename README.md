# SoftPosit.jl
Julia types for the C-based SoftPosit library - a posit arithmetic emulator.

Posit numbers are an alternative to floating-point numbers. Posits extend floats by introducing regime bits, that allow for a higher precision around one, yet a wide dynamic range of representable numbers. For further information see https://posithub.org

SoftPosit.jl emulates the following Posit number formats

  Posit(8,0), Posit(8,1), Posit(8,2)
  Posit(16,0), Posit(16,1), Posit(16,2)
  Posit(24,1), Posit(24,2)
  Posit(32,2)
  
for conversions between Integers and Floats and basic arithmetic operations +,-,*,/,sqrt

# Examples



# Requires

SoftPosit C library written by Cerlane Leong (https://gitlab.com/cerlane/SoftPosit). Please install with the julia option for shared libraries.

# Usage

src/SoftPosit.jl contains a constant SoftPositPath, set to the path of the compiled C library (where the softposit.so is located). Currently, just do an include("/path/to/SoftPosit.jl/src/SoftPosit.jl") to have the Posit types available.
