# the plan is to NOT define a Blotter as an array but rather as a Timestamp with defined type T <: FinancialInstrument
typealias Blotter{T<:FinancialAsset} Timestamp{T}

# designed to show one blotter at a time, and lined up so an array of these objects look pretty
function show{T<:FinancialAsset}(io::IO, b::Blotter{T})

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
    unit = split(string(typeof(b.value)), ".")[2]  # asset type as a string

    # currency variable
    cvar = show_currency(b)

    if b.value.quantity >= 0 
        print_with_color(:blue, io, string(b.timestamp))
        print_with_color(:blue, io, " | ")
        print_with_color(:green, io, " " * string(b.value.quantity) * ^(" ", q_len - strwidth(string(b.value.quantity))))
        print_with_color(:blue, io, unit * ^(" ", u_len - strwidth(unit)))
        print_with_color(:blue, io, ^(" ", p_len - strwidth(string(b.value.basis)))  * string(b.value.basis) * "  ") # rpad fixed b.value two spaces
        print_with_color(:blue, io, cvar * ^(" ", c_len - strwidth(cvar)))
        print_with_color(:blue, io, string(b.value.ticker))
    else
        print_with_color(:blue, io, string(b.timestamp))
        print_with_color(:blue, io, " | ")
        print_with_color(:red, io, string(b.value.quantity) * ^(" ", q_len - strwidth(string(b.value.quantity)) + 1))  # the +1 for negative value padding
        print_with_color(:blue, io, unit * ^(" ", u_len - strwidth(unit) - 1))  # adj for negative value
        print_with_color(:blue, io, ^(" ", p_len - strwidth(string(b.value.basis)))  * string(b.value.basis) * "   ") # rpad fixed b.value three spaces
        print_with_color(:blue, io, cvar * ^(" ", c_len - strwidth(cvar)))
        print_with_color(:blue, io, string(b.value.ticker))
    end
end

# helper method for show
function show_currency(b::Blotter)

    if b.value.currency == USD
        cvar = "\$"
    elseif b.value.currency == EUR
        cvar = "€"
    elseif b.value.currency == GBP
        cvar = "£"
    elseif b.value.currency == JPY
        cvar = "¥"
    elseif b.value.currency == AUD
        cvar = "AU\$"
    elseif b.value.currency == NZD
        cvar = "NZ\$"
    else
        cvar = "" 
    end
    cvar
end
# Not sure why these getindex methods only work on type FinancialAsset, but it works so hey

# ticker
function getindex(b::Vector{Timestamp}, s::Symbol)
    bval = [blot.value.ticker == s for blot in b]
    b[bval]
end

# asset type single value
function getindex(b::Vector{Timestamp}, d::DataType)
    tval = [typeof(blot.value) == d for blot in b]
    b[tval]
end

# array of asset types
function getindex(b::Vector{Timestamp}, dv::Vector{DataType})
    counter = falses(length(b))
    for i in 1:length(b)
        if typeof(b[i].value) in dv 
            counter[i] = true
        else
            nothing
        end
    end
    b[counter]
end

# currency
function getindex(b::Vector{Timestamp}, c::Currency)
    bval = [blot.value.currency == c for blot in b]
    b[bval]
end

# date
 
function getindex(b::Vector{Timestamp}, d::Union(Date, DateTime))
    ds = falses(length(b))
    for i in 1:length(b)
        if b[i].timestamp == d
            ds[i] = true
        end
    end
    b[ds]
end

# vector of dates
function getindex(b::Vector{Timestamp}, ds::Union(Vector{Date}, Vector{DateTime}))
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
function getindex(b::Vector{Timestamp}, r::Union(StepRange{Date}, StepRange{DateTime})) 
    b[[r;]]
end
