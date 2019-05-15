@testset "Eps" begin
    @testset for T in (Posit8, Posit16, Posit32,
                    # pX1_mul is not supported yet by C library
                    # Posit8_1, Posit16_1, Posit24_1,
                    Posit8_2, Posit16_2, Posit24_2)

        @test eps(T) == eps(one(T))
        @test floatmin(T) == eps(zero(T))
        if ~(T == Posit8)
            # Excluding Posit(8,0) as this test is only true for exponent bits > 0
            @test floatmax(T) == eps(floatmax(T))
        end
        @test notareal(T) == eps(notareal(T))
    end
end
