@testset "Comparison" begin
    n = 100
    fs = randn(n)
    sort!(fs)

    @testset for T in (Posit8, Posit16, Posit16_1, Posit32)
        for i in 1:n-1
            f1 = T(fs[i])
            f2 = T(fs[i+1])
            
            f1 == f2 || @test f2 > f1   # only test when not equal
            @test f2 >= f1

            f1 == f2 || @test f1 < f2   # only test when not equal
            @test f1 <= f1
        end
    end

    fs = 10*rand(n)
    @testset for T in (Posit8, Posit16, Posit16_1, Posit32)
        for f in fs
            p = T(f)
            @test p > 0
            @test p >= 0
            @test -p < 0
            @test -p <= 0
        end
    end
end
