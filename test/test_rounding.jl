@testset "Rounding" begin
    f0,f1,f2 = 1.4,1.5,2.5

    @testset for T in (Posit8, Posit16, Posit32)
        @test round(f0) == Float64(round(T(f0)))
        @test round(f1) == Float64(round(T(f1)))
        @test round(f2) == Float64(round(T(f2)))
    end
end

@testset "Floor" begin

    fs = [-1.9,-1.5,-1.1,-1.0,1.0,1.1,1.5,1.9]

    @testset for T in (Posit8, Posit16, Posit32)
        for f in fs
            @test floor(f) == Float64(floor(T(f)))
            @test ceil(f) == Float64(ceil(T(f)))
        end
    end
end
