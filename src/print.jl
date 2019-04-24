bitstring(x::Posit8) = bitstring(reinterpret(UInt8,x))
bitstring(x::Posit16) = bitstring(reinterpret(UInt16,x))
bitstring(x::Posit32) = bitstring(reinterpret(UInt32,x))
