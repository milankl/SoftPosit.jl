# bitstring via uints
Base.bitstring(x::AbstractPosit) = bitstring(reinterpret(Base.uinttype(typeof(x)),x))

"""Bitstring split into sign, regime, exponent and fraction bits.
# Example
julia> bitstring(Posit16(123)," ")
"0 11110 0 111011000"
"""
function Base.bitstring(x::AbstractPosit,mode::Symbol)
    if mode == :split
        # number of exponent bits
        ne = x isa Posit16_1 ? 1 : 2
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
        print(io2,float(x))
        f = String(take!(io2))
        print(io,string(typeof(x))*"("*f*")")
    end
end