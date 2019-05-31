@testset "ExpLogSinCosTan" begin
    @testset for T in (Posit8, Posit16, Posit32,
                    # Posit8_1, Posit16_1, Posit24_1,
                    Posit8_2, Posit16_2, Posit24_2)

        @test one(T) == sin(T(π/2))
        @test minusone(T) == cos(T(1π))

        if T != Posit8
            @test one(T) == tan(T(π/4))
        else # due to rounding errors for Posit8 this is slightly off
            @test one(T) == nextfloat(tan(T(π/4)))
        end

        @test zero(T) == tan(zero(T))

        x = T(0.5)  # doesn't work for all x due to rounding errors
        # Pythagorean Identity
        @test one(T) == sin(x)^2 + cos(x)^2

        # Parity
        @test -sin(x) == sin(-x)
        @test cos(x) == cos(-x)
        @test -tan(x) == tan(-x)

        # Euler Identity
        # @test one(T) == abs(exp(im*T(1π)))

        @test one(T) == exp(zero(T))
        @test T(16.0) == exp2(T(4.0))
        @test T(10.0) == exp10(T(1.0))

        @test zero(T) == log(one(T))
        @test T(4.0) == log2(T(16.0))
        @test one(T) == log10(T(10.0))
    end
end
