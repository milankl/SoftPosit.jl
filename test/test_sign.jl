@testset "Sign" begin
    @testset for T in (Posit8, Posit16, Posit32)
                    #Posit8_1, Posit16_1, Posit24_1,
                    #Posit8_2, Posit16_2, Posit24_2)

        @test one(T) == sign(one(T))
        @test zero(T) == sign(zero(T))
        @test minusone(T) == sign(minusone(T))
        #TODO somehow calls the wrong sign function
        #@test notareal(T) == sign(notareal(T))
    end
end
