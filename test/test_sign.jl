@testset "Sign" begin
    @testset for T in (Posit8, Posit16, Posit32,
                    # pX1_mul is not supported yet by C library
                    # Posit8_1, Posit16_1, Posit24_1,
                    Posit8_2, Posit16_2, Posit24_2)

        @test one(T) == sign(one(T))
        @test zero(T) == sign(zero(T))
        @test minusone(T) == sign(minusone(T))
        @test zero(T) == sign(notareal(T))
    end
end
