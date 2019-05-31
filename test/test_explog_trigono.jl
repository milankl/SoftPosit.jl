@testset "ExpLogSinCosTan" begin
    @testset for T in (Posit8, Posit16, Posit32,
                    # pX1_mul is not supported yet by C library
                    # Posit8_1, Posit16_1, Posit24_1,
                    Posit8_2, Posit16_2, Posit24_2)

        @test zero(T) == sin(T(Float64(π)))
        @test minusone(T) == cos(T(Float64(π)))
        @test one(T) == tan(T(π/4))

        x = T(0.2345)

        # Pythagorean Identity
        @test one(T) == sin(x)^2 + cos(x)^2

        # Parity
        @test -sin(x) == sin(-x)
        @test cos(x) == cos(-x)
        @test -tan(x) == tan(-x)

        # Euler Identity
        @test one(T) == abs(Complex{T}(exp(im*T(1π))))

        @test one(T) == exp(zero(T))
        @test zero(T) == log(one(T))
    end
end
