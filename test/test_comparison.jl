@testset "Comparison" begin
    f0,f1,f2,f3 = -0.9,-1.0,0.0,1.0

    @testset for T in (Posit8, Posit16, Posit32, Posit24_2)
        @test (f0 > f1) == (T(f0) > T(f1))
        @test (f2 >= f2) == (T(f2) >= T(f2))
        @test (f3 < f1) == (T(f3) < T(f3))
        @test T(f0) === T(f0)
    end
end
