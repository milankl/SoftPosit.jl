module SoftPosit

export AbstractPosit, Posit8, Posit16, Posit32

import Base: Float64, Float32, Float16,
    (+), (-), (*), (/), (^)

include("typedef.jl")
include("conversion.jl")
include("arithmetic.jl")

end
