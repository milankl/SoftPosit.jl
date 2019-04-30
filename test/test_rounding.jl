f0,f1,f2 = 1.4,1.5,2.5

round(f0) == Float64(round(Posit8(f0)))
round(f1) == Float64(round(Posit16(f1)))
round(f2) == Float64(round(Posit32(f2)))
