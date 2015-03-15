typealias Blotter{T<:AssetTransaction} Timestamp{T}

function show(io::IO, b::Blotter)
    print_with_color(:blue, io, string(b.timestamp))
    print_with_color(:magenta, io, " | ")
    print_with_color(:blue, io, string(b.value))
end
