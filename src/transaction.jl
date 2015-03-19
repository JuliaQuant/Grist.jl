#typealias AssetTransaction Timestamp{FinancialAsset}
#typealias AssetTransaction{T<:FinancialAsset} Timestamp{T}
typealias Blotter{T<:FinancialAsset} Timestamp{T}
#typealias Blotter Timestamp{FinancialAsset} # this fubars the show, now sure why

#function show(io::IO, at::AssetTransaction)
function show(io::IO, b::Blotter)

    # window size for column alignment

    # quantity max out at 1_000_000, ergo = 9 (7 + 2 for min spacing)
    q_len = 9
    # ShortFuture, ergo = 13 (11 + 2)
    u_len = 13
    # price max out at  9999.99, ergo = 7
    # this is also a prepend, so the suffix is fixed at 2
    p_len = 7
    # currency max out at AU$ = 5 (3 + 2)
    c_len = 5
    
    # unit variable
#    unit = split(string(typeof(b.asset)), ".")[2]  # asset type as a string
    unit = split(string(typeof(b.value)), ".")[2]  # asset type as a string

    # currency variable
#    if b.asset.currency == USD
    if b.value.currency == USD
        cvar = "\$"
    #elseif b.asset.currency == EUR
    elseif b.value.currency == EUR
        cvar = "€"
    #elseif b.asset.currency == GBP
    elseif b.value.currency == GBP
        cvar = "£"
    #elseif b.asset.currency == JPY
    elseif b.value.currency == JPY
        cvar = "¥"
    #elseif b.asset.currency == AUD
    elseif b.value.currency == AUD
        cvar = "AU\$"
    #elseif b.asset.currency == NZD
    elseif b.value.currency == NZD
        cvar = "NZ\$"
    else
        cvar = "" 
    end

    if typeof(b.value) == Stock || typeof(b.value) == LongStock || typeof(b.value) == ShortStock && b.value.shares >= 0 
        print_with_color(:green, io, " " * string(b.value.shares) * ^(" ", q_len - strwidth(string(b.value.shares))))
        print_with_color(:blue, io, unit * ^(" ", u_len - strwidth(unit)))
        print_with_color(:blue, io, ^(" ", p_len - strwidth(string(b.value.basis)))  * string(b.value.basis) * "  ") # rpad fixed b two spaces
        print_with_color(:blue, io, cvar * ^(" ", c_len - strwidth(cvar)))
        print_with_color(:blue, io, string(b.value.ticker))
    elseif b.value.contracts >= 0 
        print_with_color(:green, io, " " * string(b.value.contracts) * ^(" ", q_len - strwidth(string(b.value.contracts)))) 
        print_with_color(:blue, io, unit * ^(" ", u_len - strwidth(unit)))
        print_with_color(:blue, io, ^(" ", p_len - strwidth(string(b.value.basis)))  * string(b.value.basis) * "  ") # rpad fixed b two spaces
        print_with_color(:blue, io, cvar * ^(" ", c_len - strwidth(cvar)))
        print_with_color(:blue, io, string(b.value.ticker))
    elseif typeof(b.value) == Stock || typeof(b.value) == LongStock || typeof(b.value) == ShortStock && b.value.shares < 0 
        print_with_color(:green, io, " " * string(b.value.shares) * ^(" ", q_len - strwidth(string(b.value.shares))))
        print_with_color(:blue, io, unit * ^(" ", u_len - strwidth(unit)))
        print_with_color(:blue, io, ^(" ", p_len - strwidth(string(b.value.basis)))  * string(b.value.basis) * "  ") # rpad fixed b two spaces
        print_with_color(:blue, io, cvar * ^(" ", c_len - strwidth(cvar)))
        print_with_color(:blue, io, string(b.value.ticker))
    else b.value.contracts < 0 
        print_with_color(:green, io, " " * string(b.value.contracts) * ^(" ", q_len - strwidth(string(b.value.contracts)))) 
        print_with_color(:blue, io, unit * ^(" ", u_len - strwidth(unit)))
        print_with_color(:blue, io, ^(" ", p_len - strwidth(string(b.value.basis)))  * string(b.value.basis) * "  ") # rpad fixed b two spaces
        print_with_color(:blue, io, cvar * ^(" ", c_len - strwidth(cvar)))
        print_with_color(:blue, io, string(b.value.ticker))
    end
end

# ticker
# function getindex{T<:Blotter}(b::Vector{T}, t::Symbol)
 function getindex{T<:FinancialAsset}(b::Array{Timestamps.Timestamp{T},1}, ::Symbol)
    #bval = [blot.value.asset.ticker == t for blot in b]
    bval = [blot.value.ticker == t for blot in b]
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
