typealias Blotter{T<:AssetTransaction} Timestamp{T}

#function show(io::IO, b::Array{Blotter})
function show(io::IO, b::Blotter)
    print(io, "          ", "Qty", "Fill Price")
end
