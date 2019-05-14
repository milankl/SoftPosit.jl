@testset "Conversions" begin
    x = 1.25
    i = 4

    # Floats test conversion back and forth
    @test x == Float64(Posit8(x))
    @test x == Float64(Posit16(x))
    @test x == Float64(Posit32(x))

    @test x == Float32(Posit8_2(x))
    @test x == Float32(Posit16_2(x))
    @test x == Float32(Posit24_2(x))

    # Posit to Posit back and forth
    if Sys.isapple() || Sys.iswindows()
        @test_skip Posit8(x) == Posit8(Posit16(x))
        @test_skip Posit32(x) == Posit32(Posit16(Posit8_2(x)))
    else
        @test Posit8(x) == Posit8(Posit16(x))
        @test Posit32(x) == Posit32(Posit16(Posit8_2(x)))
    end

    # Int to posit back and forth
    @test i == Int64(Posit8(i))
    @test i == Int64(Posit16(i))
    @test i == Int64(Posit32(i))

    # Boolean tests
    @testset for T in (Posit8,Posit16,Posit32)
        T(x) == true*T(x)
        zero(T) == false*T(x)
        T(x)+one(T) == true + T(x)
        T(x) == false + T(x)
        T(true) == one(T)
        T(false) == zero(T)
    end
end
