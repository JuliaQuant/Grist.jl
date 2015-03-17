typealias Blotter Timestamp{AssetTransaction}

function show(io::IO, b::Blotter)
    print_with_color(:blue, io, string(b.timestamp))
    print_with_color(:blue, io, " | ")
    print_with_color(:blue, io, string(b.value))
end

# ticker
function getindex{T<:Blotter}(b::Vector{T}, t::Symbol)
    bval = [blot.value.asset.ticker == t for blot in b]
    b[bval]
end

# asset type single value
function getindex{T<:Blotter}(b::Vector{T}, a::DataType)
    tval = [typeof(blot.value.asset) == a for blot in b]
    b[tval]
end

# array of asset types
function getindex{T<:Blotter}(b::Vector{T}, as::Vector{DataType})
    counter = falses(length(b))
    for i in 1:length(b)
        if typeof(b[i].value.asset) in as 
            counter[i] = true
        else
            nothing
        end
    end
    b[counter]
end

# currency
function getindex{T<:Blotter}(b::Vector{T}, c::Currency)
    bval = [blot.value.asset.currency == c for blot in b]
    b[bval]
end

# date
function Base.getindex{T<:Blotter}(b::Vector{T}, d::Union(Date, DateTime))
    ds = falses(length(b))
    for i in 1:length(b)
        if b[i].timestamp == d
            ds[i] = true
        end
    end
    b[ds]
end

# vector of dates
function getindex{T<:Blotter}(b::Vector{T}, ds::Union(Vector{Date}, Vector{DateTime}))
    counter = falses(length(b))
    for i in 1:length(b)
        if b[i].timestamp in ds 
            counter[i] = true
        else
            nothing
        end
    end
    b[counter]
end

# range of dates -> converts to vector and calls above method
function getindex{T<:Blotter}(b::Vector{T}, r::Union(StepRange{Date}, StepRange{DateTime})) 
    b[[r;]]
end
