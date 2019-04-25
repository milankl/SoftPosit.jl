# direct conversion from hexadecimal or binary
Posit8(x::UInt8) = reinterpret(Posit8,x)
Posit16(x::UInt16) = reinterpret(Posit16,x)
Posit32(x::UInt32) = reinterpret(Posit32,x)

Posit8_2(x::UInt32) = reinterpret(Posit8_2,x)
Posit16_2(x::UInt32) = reinterpret(Posit16_2,x)
Posit24_2(x::UInt32) = reinterpret(Posit24_2,x)

# allow also 8bit and 16bit although internally stored as 32bit
# shift bits as conversion to UInt32 adds 0 bits to the left
# but the posit formats assume 0 bits at the right for 8,16bit
Posit8_2(x::UInt8) = Posit8_2(UInt32(x) << 24)
Posit16_2(x::UInt16) = Posit16_2(UInt32(x) << 16)

# same for Posit_1
Posit8_1(x::UInt32) = reinterpret(Posit8_1,x)
Posit16_1(x::UInt32) = reinterpret(Posit16_1,x)
Posit24_1(x::UInt32) = reinterpret(Posit24_1,x)
Posit8_1(x::UInt8) = Posit8_1(UInt32(x) << 24)
Posit16_1(x::UInt16) = Posit16_1(UInt32(x) << 16)
