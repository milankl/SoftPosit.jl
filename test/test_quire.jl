@testset "Quire" begin

    # Test 32+1-32 == 1
    # as for Posit8 32+1 = 32
    q = zero(Quire8)
    q = fma(q,Posit8(32),one(Posit8))
    q = fma(q,Posit8(1),one(Posit8))
    q = fms(q,Posit8(32),one(Posit8))
    @test one(Posit8) == Posit8(q)

    # Test 1e6 + 1 - 1e6 == 1
    # as for Posit16 1e6+1 = 1e6
    q = zero(Quire16)
    q = fma(q,Posit16(1e6),one(Posit16))
    q = fma(q,Posit16(1),one(Posit16))
    q = fms(q,Posit16(1e6),one(Posit16))
    @test one(Posit16) == Posit16(q)

    # Test 1e30 + 1 - 1e30 == 1
    # as for Posit32 1e30+1 = 1e6
    q = zero(Quire32)
    q = fma(q,Posit32(1e30),one(Posit32))
    q = fma(q,Posit32(1),one(Posit32))
    q = fms(q,Posit32(1e30),one(Posit32))
    @test one(Posit32) == Posit32(q)

    @test zero(Posit8) == Posit8(zero(Quire8))
    @test zero(Posit16) == Posit16(zero(Quire16))
    @test zero(Posit32) == Posit32(zero(Quire32))

    @test one(Posit8) == Posit8(one(Quire8))
    @test one(Posit16) == Posit16(one(Quire16))
    @test one(Posit32) == Posit32(one(Quire32))
end
