@testset "Rounding" begin
    f0,f1,f2 = 1.4,1.5,2.5

    @testset for T in (Posit8, Posit16, Posit32)
        @test round(f0) == Float64(round(T(f0)))
        @test round(f1) == Float64(round(T(f1)))
        @test round(f2) == Float64(round(T(f2)))
    end
end
