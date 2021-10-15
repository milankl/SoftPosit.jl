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

@testset "0,±1,±2,±4" begin
	for f in Float32[-4,-2,-1,0,1,2,4]
		@test Posit16(f) == Posit16_new(f)
	end
end

@testset "0,±1/2,±1/4,±1/8" begin
	for f in Float32[-1/8,-1/4,-1/2,0,1/2,1/4,1/8]
		@test Posit16(f) == Posit16_new(f)
	end
end

@testset "With zero mantissa bits" begin
	for f in Float32[	0.000244140625,
						0.0009765625,
						0.001953125,
						0.00390625,
						0.0078125,
						0.015625,
						0.03125,
						0.0625,
						0.125,
						0.25,
						0.5]
		@test Posit16(f) == Posit16_new(f)
		@test Posit16(-f) == Posit16_new(-f)
		@test Posit16(1/f) == Posit16_new(1/f)
		@test Posit16(-1/f) == Posit16_new(-1/f)
	end
end

@testset "NaN, Inf" begin
	for f in [NaN32,Inf32,-Inf32]
		@test Posit16(f) == Posit16_new(f)
	end

	for _ in 1:10
		# create various NaNs
		f = reinterpret(Float32,reinterpret(UInt32,NaN32)+(rand(UInt32)>>10))
		@test Posit16(f) == Posit16_new(f)
		@test isnan(Posit16_new(f))
	end
end

@testset "U(0,1)" begin
	for f in rand(Float32,100)
		@test Posit16(f) == Posit16_new(f)
	end
end

@testset "U(1,21)" begin
	for f in 1 .+ 20*rand(Float32,100)
		@test Posit16(-f) == Posit16_new(-f)
		@test Posit16(f) == Posit16_new(f)
	end
end

@testset "N(0,1)" begin
	for f in randn(Float32,100)
		@test Posit16(f) == Posit16_new(f)
	end
end