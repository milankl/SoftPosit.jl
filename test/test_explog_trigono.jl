@testset "ExpLogSinCosTan" begin
    @testset for T in (Posit8, Posit16, Posit32,
                    # pX1_mul is not supported yet by C library
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
        @test zero(T) == log(one(T))
    end
end
