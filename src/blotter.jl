typealias Blotter{T<:AssetTransaction} Timestamp{T}


function show(io::IO, b::Blotter)
    print_with_color(:blue, io, string(b.timestamp))
    print_with_color(:blue, io, " | ")
    print_with_color(:blue, io, string(b.value))
end

# ticker
function getindex{T<:Blotter}(b::Array{T}, t::Symbol)
    bval = [blot.value.asset.ticker == t for blot in b]
    b[bval]
end

# currency
function getindex{T<:Blotter}(b::Array{T}, c::Currency)
    bval = [blot.value.asset.currency == c for blot in b]
    b[bval]
end
