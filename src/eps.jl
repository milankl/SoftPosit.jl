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

eps(p::AbstractPosit) = max(p-prevfloat(p),nextfloat(p)-p)
