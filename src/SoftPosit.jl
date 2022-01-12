module SoftPosit

    import SoftPosit_jll
    # For compatibility with previous versions of SofPosit.jl which used the name
    # `SoftPositPath`.
    const SoftPositPath = SoftPosit_jll.softposit

    export AbstractPosit, Posit8, Posit16, Posit32,
        Posit8_1, Posit16_1, Posit24_1,
        Posit8_2, Posit16_2, Posit24_2,
        notareal, minusone,
        AbstractQuire, Quire8, Quire16, Quire32, fms,
        Posit16_old, Float32_old

    import Base: Float64, Float32, Float16, Int32, Int64,
        UInt8, UInt16, UInt32,
        (+), (-), (*), (/), (<), (<=), (==), sqrt,
        bitstring, round, one, zero, promote_rule, eps,
        floatmin, floatmax, signbit, sign, isfinite,
        nextfloat, prevfloat, fma,
        exp, exp2, exp10, log, log2, log10, cos, sin, tan,
        expm1,log1p

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
