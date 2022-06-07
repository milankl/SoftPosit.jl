module SoftPosit

    # import SoftPosit_jll
    # # For compatibility with previous versions of SofPosit.jl which used the name
    # # `SoftPositPath`.
    # const SoftPositPath = SoftPosit_jll.softposit

    export AbstractPosit, Posit8, Posit16, Posit32, Posit16_1,
        notareal
        # AbstractQuire, Quire8, Quire16, Quire32, fms

    include("typedef.jl")
    include("comparisons.jl")
    include("constants.jl")
    # include("conversions.jl")
    include("arithmetics.jl")
    # include("round.jl")
    include("print.jl")
end
