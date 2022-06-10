@testset "Nextfloat" begin
    @testset for T in (Posit8, Posit16, Posit16_1, Posit32)
        N = 100
        for _ in 1:N
            i = rand(Base.uinttype(T))
            @test T(i) == nextfloat(prevfloat(T(i)))
            @test T(i) == prevfloat(nextfloat(T(i)))
        end
    end
end
