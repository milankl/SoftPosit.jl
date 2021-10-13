bitstring(x::Posit8) = bitstring(reinterpret(UInt8,x))
bitstring(x::Posit16) = bitstring(reinterpret(UInt16,x))
bitstring(x::Posit32) = bitstring(reinterpret(UInt32,x))

bitstring(x::Posit8_1) = bitstring(UInt8(reinterpret(UInt32,x) >> 24))
bitstring(x::Posit8_2) = bitstring(UInt8(reinterpret(UInt32,x) >> 24))

bitstring(x::Posit16_1) = bitstring(UInt16(reinterpret(UInt32,x) >> 16))
bitstring(x::Posit16_2) = bitstring(UInt16(reinterpret(UInt32,x) >> 16))

# cut off the string as UInt24 does not exist
bitstring(x::Posit24_1) = bitstring(reinterpret(UInt32,x))[1:24]
bitstring(x::Posit24_2) = bitstring(reinterpret(UInt32,x))[1:24]

"""Bitstring split into sign, regime, exponent and fraction bits.
# Example
julia> bitstring(Posit16(123)," ")
"0 11110 0 111011000"
"""
function bitstring(x::AbstractPosit,mode::Symbol)
    if mode == :split
        # number of exponent bits
        ne = if x isa PositEx1 1 elseif x isa PositEx2 2 else 0 end
        s = bitstring(x)
        n = n_regimebits(s)

        # concatenate the string
        if n >= length(s)-2     # only exponent bits (possibly including terminating bit)
            return "$(s[1]) $(s[2:end])"
        elseif n > length(s)-ne-3
            return "$(s[1]) $(s[2:2+n]) $(s[2+n+1:end])"
        else
            if ne == 0
                return "$(s[1]) $(s[2:2+n]) $(s[2+n+1:end])"
            else
                return "$(s[1]) $(s[2:2+n]) $(s[2+n+1:2+n+ne]) $(s[2+n+ne+1:end])"
            end
        end
    else
        return bitstring(x)
    end
end

"""Number of regime bits for a posit bitstring, excluding the terminating bit.
# Example
julia> n_regimebits("0111100111011000")
4"""
function n_regimebits(s::String)
    n = 2   # skip the sign bit
    slength = length(s)
    while n < slength && s[n+1] == s[n]
        n += 1
    end
    n-1     # subtract the sign bit
end

function Base.show(io::IO, x::AbstractPosit)
    if isnan(x)
        print(io, "NaR")
    else
		io2 = IOBuffer()
        print(io2,Float32(x))
        f = String(take!(io2))
        print(io,string(typeof(x))*"("*f*")")
    end
end