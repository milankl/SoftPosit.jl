bitstring(x::Posit8) = bitstring(reinterpret(UInt8,x))
bitstring(x::Posit16) = bitstring(reinterpret(UInt16,x))
bitstring(x::Posit32) = bitstring(reinterpret(UInt32,x))

bitstring(x::Posit8_1) = bitstring(reinterpret(UInt32,x))[1:8]
bitstring(x::Posit8_2) = bitstring(reinterpret(UInt32,x))[1:8]

bitstring(x::Posit16_1) = bitstring(reinterpret(UInt32,x))[1:16]
bitstring(x::Posit16_2) = bitstring(reinterpret(UInt32,x))[1:16]

bitstring(x::Posit24_1) = bitstring(reinterpret(UInt32,x))[1:24]
bitstring(x::Posit24_2) = bitstring(reinterpret(UInt32,x))[1:24]
