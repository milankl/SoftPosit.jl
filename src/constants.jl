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
        one(::$T) = $T(0x40000000)
        zero(::$T) = $T(0x00000000)
        maxpos(::$T) = $T(0x7fffffff)
        minpos(::$T) = $T(0x00000001)
        minneg(::$T) = $T(0x80000001)
        maxneg(::$T) = $T(0xffffffff)

        # unary minus
        -(x::$T) = x*$T(0xc0000000)
    end
end

# special case for Posit24_2 - 24bits plus 8bits that are always 0
for T in (:Posit24_1, :Posit24_2)
    @eval begin
        one(::$T) = $T(0x40000000)
        zero(::$T) = $T(0x00000000)
        maxpos(::$T) = $T(0x7fffff00)
        minpos(::$T) = $T(0x00000100)
        minneg(::$T) = $T(0x80000100)
        maxneg(::$T) = $T(0xffffff00)

        # unary minus
        -(x::$T) = x*$T(0xc0000000)
    end
end
