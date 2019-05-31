@testset "Promotion" begin
    @testset for T in (Posit8, Posit16, Posit32,
                    #Posit8_1, Posit16_1, Posit24_1,
                    Posit8_2, Posit16_2, Posit24_2)

        @test 2*one(T) == T(2)
    end
end
