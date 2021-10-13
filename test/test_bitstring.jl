@testset "Bitstring" begin

    @testset for f in (-64.0,-1.0,-1e-2,1e-1,1.0,64.0)
        for T in (Posit8,Posit8_2)
            T(f) == T(parse(UInt8,bitstring(T(f)),base=2))
        end

        for T in (Posit16,Posit16_2)
            T(f) == T(parse(UInt16,bitstring(T(f)),base=2))
        end

        # don't test for Posit24_2 as there is no 24bit UInt format.
        # rely on bitstring(p,:split) testing

        Posit32(f) == Posit32(parse(UInt32,bitstring(Posit32(f)),base=2))
    end

    # Posit8
    @test "0 10 00000" == bitstring(Posit8(1),:split)
    @test "0 111110 1" == bitstring(Posit8(24),:split)
    @test "0 1111110" == bitstring(Posit8(32),:split)
    @test "0 1111111" == bitstring(Posit8(64),:split)

    # Posit16
    @test "0 111111111111110" == bitstring(Posit16(1e8),:split)
    @test "0 11111111111110 1" == bitstring(Posit16(5e7),:split)
    @test "0 1111111111110 1 0" == bitstring(Posit16(1e7),:split)
    @test "0 10 0 000000000000" == bitstring(Posit16(1),:split)

    # Posit32
    @test "0 1111111111111111111111111111110" == bitstring(Posit32(1e35),:split)
    @test "0 111111111111111111111111111110 0" == bitstring(Posit32(1e34),:split)
    @test "0 11111111111111111111111111110 10" == bitstring(Posit32(1e33),:split)
    @test "0 1111111111111111111111111110 10 0" == bitstring(Posit32(1e32),:split)
    @test "0 10 00 000000000000000000000000000" == bitstring(Posit32(1),:split)

    # Posit8_2
    @test "0 10 00 000" == bitstring(Posit8_2(1),:split)
    @test "0 11110 01" == bitstring(Posit8_2(1e4),:split)
    @test "0 111110 0" == bitstring(Posit8_2(1e5),:split)
    @test "0 1111110" == bitstring(Posit8_2(1e6),:split)

    # Posit16_2
    @test "0 10 00 00000000000" == bitstring(Posit16_2(1),:split)
    @test "0 111111111111110" == bitstring(Posit16_2(1e16),:split)
    @test "0 11111111111110 1" == bitstring(Posit16_2(1e15),:split)
    @test "0 1111111111110 10" == bitstring(Posit16_2(1e14),:split)

    # Posit24_2
    @test "0 11111111111111111111110" == bitstring(Posit24_2(1e25),:split)
    @test "0 1111111111111111111110 0" == bitstring(Posit24_2(1e24),:split)
    @test "0 111111111111111111110 00" == bitstring(Posit24_2(1e23),:split)
    @test "0 10 00 0000000000000000000" == bitstring(Posit24_2(1),:split)

end
