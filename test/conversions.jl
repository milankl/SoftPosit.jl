include("lookup_tables.jl")

@testset "Float(Posit8)" begin
    # all positive posits
    for i in 0x00:0x7f
        @test Posit8_lookup[i+1] == Float32(Posit8(i))
        @test Posit8_lookup[i+1] == Float64(Posit8(i))

        # some Float16s are outside the Posit8 range
        f16 = Float16(Posit8(i))
        if isfinite(f16)
            @test Posit8_lookup[i+1] == f16
        end
    end

    # special case for NaN due to == testing
    @test isnan(Float16(Posit8(0x80)))
    @test isnan(Float32(Posit8(0x80)))
    @test isnan(Float64(Posit8(0x80)))

    # all negative posits
    for i in 0x81:0xff
        @test Posit8_lookup[i+1] == Float32(Posit8(i))
        @test Posit8_lookup[i+1] == Float64(Posit8(i))

        # some Float16s are outside the Posit8 range
        f16 = Float16(Posit8(i))
        if isfinite(f16)
            @test Posit8_lookup[i+1] == f16
        end
    end
end

@testset "Float(Posit16)" begin

    @test iszero(Float32(Posit16(0x0000)))

    # test the first 64 non-zero values and their negation
    for i in 0x0001:0x0040  
        @test Posit16_lookup[i+1] == Float32(Posit16(i))
        @test Posit16_lookup[i+1] == Float64(Posit16(i))


        j = 0xffff-i+0x1
        @test Posit16_lookup[i+1] == -Float32(Posit16(j))
        @test Posit16_lookup[i+1] == -Float64(Posit16(j))
    end

    # test the first 8 values (mantissa=0) also on their inverse and negation
    for i in 0x0001:0x0008
        j = 0x8000-i  
        @test Posit16_lookup[i+1] == 1/Float32(Posit16(j))
        @test Posit16_lookup[i+1] == 1/Float64(Posit16(j))

        j = 0x8000+i  
        @test Posit16_lookup[i+1] == -1/Float32(Posit16(j))
        @test Posit16_lookup[i+1] == -1/Float64(Posit16(j))
    end

    @test isnan(Float32(Posit16(0x8000)))
    @test isnan(Float64(Posit16(0x8000)))
end

@testset "Float(Posit16_1)" begin

    @test iszero(Float32(Posit16_1(0x0000)))
    @test iszero(Float64(Posit16_1(0x0000)))

    # test the first 64 non-zero values and their negation
    for i in 0x0001:0x0040  
        @test Posit161_lookup[i+1] == Float32(Posit16_1(i))
        @test Posit161_lookup[i+1] == Float64(Posit16_1(i))

        j = 0xffff-i+0x1
        @test Posit161_lookup[i+1] == -Float32(Posit16_1(j))
        @test Posit161_lookup[i+1] == -Float64(Posit16_1(j))
    end

    # test the first 4 values (mantissa=0) also on their inverse and negation
    for i in 0x0001:0x0004
        j = 0x8000-i  
        @test Posit161_lookup[i+1] == 1/Float32(Posit16_1(j))
        @test Posit161_lookup[i+1] == 1/Float64(Posit16_1(j))

        j = 0x8000+i  
        @test Posit161_lookup[i+1] == -1/Float32(Posit16_1(j))
        @test Posit161_lookup[i+1] == -1/Float64(Posit16_1(j))
    end

    @test isnan(Float32(Posit16_1(0x8000)))
end

@testset "Float(Posit32)" begin

    @test iszero(Float32(Posit32(0x0000_0000)))
    @test iszero(Float64(Posit32(0x0000_0000)))

    # test the first 64 non-zero values and their negation
    for i in 0x0000_0001:0x0000_0040  
        @test Float32(Posit32_lookup[i+1]) == Float32(Posit32(i))
        @test Posit32_lookup[i+1] == Float64(Posit32(i))

        j = 0xffff_ffff-i+0x1
        @test Float32(Posit32_lookup[i+1]) == -Float32(Posit32(j))
        @test Posit32_lookup[i+1] == -Float64(Posit32(j))
    end

    # test the first 8 values (mantissa=0) also on their inverse and negation
    for i in 0x0000_0001:0x0000_0008
        j = 0x8000_0000-i  
        @test Float32(Posit32_lookup[i+1]) == 1/Float32(Posit32(j))
        @test Posit32_lookup[i+1] == 1/Float64(Posit32(j))

        j = 0x8000_0000+i  
        @test Float32(Posit32_lookup[i+1]) == -1/Float32(Posit32(j))
        @test Posit32_lookup[i+1] == -1/Float64(Posit32(j))
    end

    @test isnan(Float32(Posit32(0x8000_0000)))
    @test isnan(Float64(Posit32(0x8000_0000)))
end

@testset "Posit8 idempotence" begin
    for i in 0x00:0xff
        @test Posit8(i) == Posit8(Float32(Posit8(i)))
        @test Posit8(i) == Posit8(Float64(Posit8(i)))
        @test Posit8(i) == Posit8(Posit16(Posit8(i)))
        @test Posit8(i) == Posit8(Posit32(Posit8(i)))
    end
end

@testset "Posit16 idempotence" begin
    N = 1000
    for i in rand(UInt16,N)
        @test Posit16(i) == Posit16(Float32(Posit16(i)))
        @test Posit16(i) == Posit16(Float64(Posit16(i)))
        @test Posit16(i) == Posit16(Posit32(Posit16(i)))
    end
end

@testset "Posit16_1 idempotence" begin
    N = 1000
    for i in rand(UInt16,N)
        @test Posit16_1(i) == Posit16_1(Float32(Posit16_1(i)))
        @test Posit16_1(i) == Posit16_1(Float64(Posit16_1(i)))
    end
end

@testset "Posit32 idempotence" begin
    N = 1000
    for i in rand(UInt32,N)
        @test Posit32(i) == Posit32(Float64(Posit32(i)))
    end
end

@testset "Conversions: infinity" begin

    # FLOAT TO POSIT
    @test isnan(Posit8(Inf))
    @test isnan(Posit8(Inf32))
    @test isnan(Posit16(Inf))
    @test isnan(Posit16(Inf32))
    @test isnan(Posit16_1(Inf))
    @test isnan(Posit16_1(Inf32))
    @test isnan(Posit32(Inf))
    @test_skip isnan(Posit32(Inf32))

    @test isnan(Posit8(-Inf))
    @test isnan(Posit8(-Inf32))
    @test isnan(Posit16(-Inf))
    @test isnan(Posit16(-Inf32))
    @test isnan(Posit16_1(-Inf))
    @test isnan(Posit16_1(-Inf32))
    @test isnan(Posit32(-Inf))
    @test_skip isnan(Posit32(-Inf32))
end

@testset "Conversions: NaN" begin

    # FLOAT TO POSIT
    @test isnan(Posit8(NaN))
    @test isnan(Posit8(NaN32))
    @test isnan(Posit16(NaN))
    @test isnan(Posit16(NaN32))
    @test isnan(Posit16_1(NaN))
    @test isnan(Posit16_1(NaN32))
    @test isnan(Posit32(NaN))
    @test_skip isnan(Posit32(NaN32))

    @test isnan(Posit8(-NaN))
    @test isnan(Posit8(-NaN32))
    @test isnan(Posit16(-NaN))
    @test isnan(Posit16(-NaN32))
    @test isnan(Posit16_1(-NaN))
    @test isnan(Posit16_1(-NaN32))
    @test isnan(Posit32(-NaN))
    @test_skip isnan(Posit32(-NaN32))

    # # POSIT TO FLOAT
    @test isnan(Float16(notareal(Posit8)))
    @test isnan(Float32(notareal(Posit8)))
    @test isnan(Float64(notareal(Posit8)))

    @test isnan(Float16(notareal(Posit16)))
    @test isnan(Float32(notareal(Posit16)))
    @test isnan(Float64(notareal(Posit16)))
    
    @test isnan(Float16(notareal(Posit16_1)))
    @test isnan(Float32(notareal(Posit16_1)))
    @test isnan(Float64(notareal(Posit16_1)))
    
    @test isnan(Float16(notareal(Posit32)))
    @test isnan(Float32(notareal(Posit32)))
    @test isnan(Float64(notareal(Posit32)))
end

@testset "No underflow" begin
    @test floatmin(Posit8) == Posit8(4*floatmin(Float32))
    @test floatmin(Posit8) == Posit8(4*floatmin(Float64))

    @test -floatmin(Posit8) == Posit8(-4*floatmin(Float32))
    @test -floatmin(Posit8) == Posit8(-4*floatmin(Float64))

    @test floatmin(Posit16) == Posit16(4*floatmin(Float32))
    @test floatmin(Posit16) == Posit16(4*floatmin(Float64))

    @test -floatmin(Posit16) == Posit16(-4*floatmin(Float32))
    @test -floatmin(Posit16) == Posit16(-4*floatmin(Float64))

    @test floatmin(Posit16_1) == Posit16_1(4*floatmin(Float32))
    @test floatmin(Posit16_1) == Posit16_1(4*floatmin(Float64))

    @test -floatmin(Posit16_1) == Posit16_1(-4*floatmin(Float32))
    @test -floatmin(Posit16_1) == Posit16_1(-4*floatmin(Float64))

    @test_skip floatmin(Posit32) == Posit32(4*floatmin(Float32))
    @test floatmin(Posit32) == Posit32(4*floatmin(Float64))

    @test_skip -floatmin(Posit32) == Posit32(-4*floatmin(Float32))
    @test -floatmin(Posit32) == Posit32(-4*floatmin(Float64))
end

@testset "No overflow" begin
    @test floatmax(Posit8) == Posit8(floatmax(Float32))
    @test floatmax(Posit8) == Posit8(floatmax(Float64))

    @test -floatmax(Posit8) == Posit8(-floatmax(Float32))
    @test -floatmax(Posit8) == Posit8(-floatmax(Float64))

    @test floatmax(Posit16) == Posit16(floatmax(Float32))
    @test floatmax(Posit16) == Posit16(floatmax(Float64))

    @test -floatmax(Posit16) == Posit16(-floatmax(Float32))
    @test -floatmax(Posit16) == Posit16(-floatmax(Float64))

    @test floatmax(Posit16_1) == Posit16_1(floatmax(Float32))
    @test floatmax(Posit16_1) == Posit16_1(floatmax(Float64))

    @test -floatmax(Posit16_1) == Posit16_1(-floatmax(Float32))
    @test -floatmax(Posit16_1) == Posit16_1(-floatmax(Float64))

    @test_skip floatmax(Posit32) == Posit32(floatmax(Float32))
    @test floatmax(Posit32) == Posit32(floatmax(Float64))

    @test_skip -floatmax(Posit32) == Posit32(-floatmax(Float32))
    @test -floatmax(Posit32) == Posit32(-floatmax(Float64))
end

@testset "No overflow" begin
    @testset for T in (Posit8,Posit16,Posit16_1,Posit32)
        for x in 5:0.1:100
            # from Float64
            @test isfinite(T( 10.0 ^ x))    # overflow
            @test isfinite(T(-10.0 ^ x))    # overflow in negative
        end

        for x in 5:0.1:38
            # from Float32
            @test isfinite(T( 10f0 ^ x))    # overflow
            @test isfinite(T(-10f0 ^ x))    # overflow in negative
        end

        @testset for F in (Float32,Float64)
            @test isfinite(T(floatmax(F)))
            @test isfinite(T(-floatmax(F)))
            @test ~isfinite(T(floatmax(F)*2))
            @test ~isfinite(T(-floatmax(F)*2))
            @test ~isfinite(T(F(Inf)))
            @test ~isfinite(T(F(-Inf)))
        end
    end
end

@testset "Bool conversion" begin
    x = rand(Float64)
    @testset for T in (Posit8,Posit16,Posit32)
        @test T(x) == true*T(x)
        @test zero(T) == false*T(x)
        @test T(x)+one(T) == true + T(x)
        @test T(x) == false + T(x)
        @test T(true) == one(T)
        @test T(false) == zero(T)
    end
end

@testset "Integer conversion" begin
    @testset for T in (Posit8,Posit16,Posit16_1,Posit32)
        for i in -8:8
            @test i == Int(T(i))
            @test 2i == Int(2*T(i))
        end
    end
end