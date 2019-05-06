for P in (:Posit8, :Posit16, :Posit32,
        :Posit8_1, :Posit16_1, :Posit24_1,
        :Posit8_2, :Posit16_2, :Posit24_2)
        @eval begin
                $P(x::Bool) = if x one(P) else zero(P) end
                promote_rule(::Type{Bool},::Type{$P}) = $P
        end
end
