@testset "Nextfloat" begin
    @testset for T in (Posit8, Posit16, Posit32,

                    # Doesn't work yet because -PositX1 requires pX1_mul
                    # Posit8_1, Posit16_1, Posit24_1,
                    Posit8_2, Posit16_2, Posit24_2)

        @test -floatmax(T) == nextfloat(nextfloat(floatmax(T)))
        @test -floatmin(T) == prevfloat(prevfloat(floatmin(T)))
    end
end
