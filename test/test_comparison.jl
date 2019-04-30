f0,f1,f2,f3 = -0.9,-1.0,0.0,1.0

(f0 > f1) == (Posit8(f0) > Posit8(f1))
(f2 >= f2) == (Posit16(f2) >= Posit16(f2))
(f3 < f1) == (Posit32(f3) < Posit32(f3))
Posit24_2(f0) == Posit24_2(f0)
