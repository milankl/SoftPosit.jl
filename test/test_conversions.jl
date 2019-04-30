x = 1.25
i = 4

# Floats test conversion back and forth
x == Float64(Posit8(x))
x == Float64(Posit16(x))
x == Float64(Posit32(x))

x == Float32(Posit8_2(x))
x == Float32(Posit16_2(x))
x == Float32(Posit24_2(x))

# Posit to Posit back and forth
Posit8(x) == Posit8(Posit16(x))
Posit32(x) == Posit32(Posit16(Posit8_2(x)))

# Int to posit back and forth
i == Int64(Posit8(i))
i == Int64(Posit16(i))
i == Int64(Posit32(i))
