module SoftPosit

export AbstractPosit, Posit8, Posit16, Posit32,
    Posit8_1, Posit16_1, Posit24_1,
    Posit8_2, Posit16_2, Posit24_2

import Base: Float64, Float32, Float16, Int32, Int64,
    (+), (-), (*), (/), (<), (<=), (==), sqrt,
    bitstring, round, one, zero, promote_rule, eps,
    floatmin, floatmax

# Load in `deps.jl`, complaining if it does not exist
const depsjl_path = joinpath(@__DIR__, "..", "deps", "deps.jl")
if !isfile(depsjl_path)
    error("SoftPosit not installed properly, run \"]build SoftPosit\", restart Julia and try again")
end
include(depsjl_path)

include("typedef.jl")
include("conversionFloatToPosit.jl")
include("conversionPositToFloat.jl")
include("conversionPositToPosit.jl")
include("conversionIntToPosit.jl")
include("conversionPositToInt.jl")
include("conversionHexBinToPosit.jl")
include("conversionBoolToPosit.jl")
include("arithmetic.jl")
include("comparison.jl")
include("constants.jl")
include("round.jl")
include("print.jl")

end
