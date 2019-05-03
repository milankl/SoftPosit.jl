# literal zero and one (via reinterpretation of hexadecimal)
# maxpos: largest representable real
# minpos: smallest representable number larger than 0
# minneg: smallest representable real
# maxneg: largest representable number smaller than 0

for T in (:Posit8, :Posit8_1, :Posit8_2)
    @eval begin
        one(::$T) = $T(0x40)
        zero(::$T) = $T(0x00)
        maxpos(::$T) = $T(0x7f)
        minpos(::$T) = $T(0x01)
        minneg(::$T) = $T(0x81)
        maxneg(::$T) = $T(0xff)

        # unary minus
        -(x::$T) = x*$T(0xc0)
    end
end

for T in (:Posit16, :Posit16_1, :Posit16_2)
    @eval begin
        one(::$T) = $T(0x4000)
        zero(::$T) = $T(0x0000)
        maxpos(::$T) = $T(0x7fff)
        minpos(::$T) = $T(0x0001)
        minneg(::$T) = $T(0x8001)
        maxneg(::$T) = $T(0xffff)

        # unary minus
        -(x::$T) = x*$T(0xc000)
    end
end

for T in (:Posit32,)
    @eval begin
        one(::$T) = $T(0x4000_0000)
        zero(::$T) = $T(0x0000_0000)
        maxpos(::$T) = $T(0x7fff_ffff)
        minpos(::$T) = $T(0x0000_0001)
        minneg(::$T) = $T(0x8000_0001)
        maxneg(::$T) = $T(0xffff_ffff)

        # unary minus
        -(x::$T) = x*$T(0xc000_0000)
    end
end

# special case for Posit24_2 - 24bits plus 8bits that are always 0
for T in (:Posit24_1, :Posit24_2)
    @eval begin
        one(::$T) = $T(0x4000_0000)
        zero(::$T) = $T(0x0000_0000)
        maxpos(::$T) = $T(0x7fff_ff00)
        minpos(::$T) = $T(0x0000_0100)
        minneg(::$T) = $T(0x8000_0100)
        maxneg(::$T) = $T(0xffff_ff00)

        # unary minus
        -(x::$T) = x*$T(0xc000_0000)
    end
end

eps(::Type{Posit8}) = Posit8(0x02)
eps(::Type{Posit16}) = Posit16(0x0100)
eps(::Type{Posit32}) = Posit32(0x00a0_0000)

#TODO remove subtraction once pX1_sub is available in the C version
eps(::Type{Posit8_1}) = Posit8_1(0x41) - Posit8_1(0x40)
eps(::Type{Posit16_1}) = Posit16_1(0x4001) - Posit16_1(0x4000)
eps(::Type{Posit24_1}) = Posit24_1(0x4000_01) - Posit24_1(0x4000_00)

eps(::Type{Posit8_2}) = Posit8_2(0x2800_0000)
eps(::Type{Posit16_2}) = Posit16_2(0x0a00_0000)
eps(::Type{Posit24_2}) = Posit24_2(0x0280_0000)
