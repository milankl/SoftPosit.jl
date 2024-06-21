@testset "Bitround identity" begin
    @testset for UIntN in (UInt8, UInt16, UInt32, UInt64)
        N = 10
        for ui in rand(UIntN, N)
            @test SoftPosit.bitround(UIntN, ui) == ui
        end
    end
end

@testset "Bitround round to nearest, tie to even" begin

    N = 100_000

    # UInt16 -> UInt8
    for ui8 in rand(UInt8, N)
        ui16 = (ui8 % UInt16) << 8      # pad with zeros
        @test SoftPosit.bitround(UInt8, ui16) == ui8

        ui16_ones = ui16 | 0x00ff      # pad with ones
        @test SoftPosit.bitround(UInt8, ui16_ones) == ui8 + 0x1

        ui16_rd = ui16 | 0x007f         # just less than ulp (all round down)
        @test SoftPosit.bitround(UInt8, ui16_rd) == ui8

        ui16_ru = ui16 | 0x0081         # just more than ulp (all round up)
        @test SoftPosit.bitround(UInt8, ui16_ru) == ui8 + 0x1

        ui16_tie = ui16 | 0x0080        # tie to even
        @test SoftPosit.bitround(UInt8, ui16_tie) == ui8 + (ui8 & 0x1)
    end

    # UInt32 -> UInt16
    for ui16 in rand(UInt16, N)
        ui32 = (ui16 % UInt32) << 16    # pad with zeros
        @test SoftPosit.bitround(UInt16, ui32) == ui16

        ui32_ones = ui32 | 0x0000_ffff  # pad with ones
        @test SoftPosit.bitround(UInt16, ui32_ones) == ui16 + 0x1

        ui32_rd = ui32 | 0x0000_7fff    # just less than ulp (all round down)
        @test SoftPosit.bitround(UInt16, ui32_rd) == ui16

        ui32_ru = ui32 | 0x0000_8001 # just more than ulp (all round up)
        @test SoftPosit.bitround(UInt16, ui32_ru) == ui16 + 0x1

        ui32_tie = ui32 | 0x0000_8000 # tie to even
        @test SoftPosit.bitround(UInt16, ui32_tie) == ui16 + (ui16 & 0x1)
    end

    # UInt64 -> UInt32
    for ui32 in rand(UInt32, N)
        ui64 = (ui32 % UInt64) << 32    # pad with zeros
        @test SoftPosit.bitround(UInt32, ui64) == ui32

        ui64_ones = ui64 | 0x0000_0000_ffff_ffff  # pad with ones
        @test SoftPosit.bitround(UInt32, ui64_ones) == ui32 + 0x1

        ui64_rd = ui64 | 0x0000_0000_7fff_ffff    # just less than ulp (all round down)
        @test SoftPosit.bitround(UInt32, ui64_rd) == ui32

        ui64_ru = ui64 | 0x0000_0000_8000_0001    # just more than ulp (all round up)
        @test SoftPosit.bitround(UInt32, ui64_ru) == ui32 + 0x1

        ui64_tie = ui64 | 0x0000_8000_0000        # tie to even
        @test SoftPosit.bitround(UInt32, ui64_tie) == ui32 + (ui32 & 0x1)
    end

    # UInt32 -> UInt8
    for ui8 in rand(UInt8, N)
        ui32 = (ui8 % UInt32) << 24     # pad with zeros
        @test SoftPosit.bitround(UInt8, ui32) == ui8

        ui32_ones = ui32 | 0x00ff_ffff  # pad with ones
        @test SoftPosit.bitround(UInt8, ui32_ones) == ui8 + 0x1

        ui32_rd = ui32 | 0x007f_ffff    # just less than ulp (all round down)
        @test SoftPosit.bitround(UInt8, ui32_rd) == ui8

        ui32_ru = ui32 | 0x0080_0001    # just more than ulp (all round up)
        @test SoftPosit.bitround(UInt8, ui32_ru) == ui8 + 0x1

        ui32_tie = ui32 | 0x0080_0000   # tie to even
        @test SoftPosit.bitround(UInt8, ui32_tie) == ui8 + (ui8 & 0x1)
    end
end

@testset "Bitround upcasting (=no rounding, pad with zeros)" begin
    @testset for (UIntN1, UIntN2) in zip((UInt8,  UInt16, UInt32),
                                         (UInt16, UInt32, UInt64))
        N = 100000
        for ui in rand(UIntN1, N)
            Δb = SoftPosit.bitsize(UIntN2) - SoftPosit.bitsize(UIntN1)
            @test SoftPosit.bitround(UIntN2, ui) >> Δb  == ui
        end
    end
end