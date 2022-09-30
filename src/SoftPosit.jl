module SoftPosit

    export AbstractPosit, Posit8, Posit16, Posit32, Posit16_1,
        notareal

    include("type_definitions.jl")
    include("comparisons.jl")
    include("constants.jl")
    include("conversions.jl")
    include("arithmetics.jl")
    include("print.jl")
end
