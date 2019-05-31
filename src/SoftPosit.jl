module SoftPosit

export AbstractPosit, Posit8, Posit16, Posit32,
    Posit8_1, Posit16_1, Posit24_1,
    Posit8_2, Posit16_2, Posit24_2,
    notareal, minusone,
    AbstractQuire, Quire8, Quire16, Quire32, fms

import Base: Float64, Float32, Float16, Int32, Int64,
    (+), (-), (*), (/), (<), (<=), (==), sqrt,
    bitstring, round, one, zero, promote_rule, eps,
    floatmin, floatmax, signbit, sign, isfinite,
    nextfloat, prevfloat, fma,
    exp, log, cos, sin, tan

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
include("conversionQuire.jl")
include("arithmetic.jl")
include("comparison.jl")
include("constants.jl")
include("round.jl")
include("print.jl")
include("nextprevfloat.jl")
include("eps.jl")
include("quire.jl")
include("explog_trigonometric.jl")

end
