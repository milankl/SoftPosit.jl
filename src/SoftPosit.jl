# module SoftPosit
#
# export AbstractPosit, Posit8, Posit16, Posit32,
#     castP8, castP16, castP32

import Base: Float64, Float32, Float16,
    (+), (-), (*), (/), (<), (<=), sqrt,
    bitstring, round

include("typedef.jl")
include("conversion.jl")
include("arithmetic.jl")
include("print.jl")

# end
