@testset "Arithmetics" begin
    f0,f1,f2,f3,f4 = 0.125,-0.5,1.75,2.5,0.0

    # basic arithmetic operations
    @testset for T in (Posit8, Posit16, Posit16_1, Posit32)
        @test T(f0 + f1 * f2 - f3) == T(f0) + T(f1) * T(f2) - T(f3)
        @test T(f0 / f1) == T(f0) / T(f1)
        @test T(sqrt(f0) * f1 / f3) == sqrt(T(f0)) * T(f1) / T(f3)
        @test T(f1) ^ 2 == T(f1 ^ 2)
        @test isnan(one(T)/zero(T))
    end
end
