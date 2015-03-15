immutable AssetTransaction
    quantity::Int
    price::Float64
    asset::FinancialAsset
end

function show(io::IO, at::AssetTransaction)
    
    # unit variable
    if typeof(at.asset) == Stock || typeof(at.asset) == LongStock || typeof(at.asset) == ShortStock 
        unit = "shares"
    else
        unit = "contracts"
    end

    # currency variable
    if at.asset.currency == USD
        cvar = "\$"
    elseif at.asset.currency == EUR
        cvar = "€"
    elseif at.asset.currency == GBP
        cvar = "£"
    elseif at.asset.currency == JPY
        cvar = "¥"
    elseif at.asset.currency == AUD
        cvar = "AU\$"
    elseif at.asset.currency == NZD
        cvar = "NZ\$"
    else
        cvar = "" 
    end

    if at.quantity >= 0 && unit == "shares"
        print_with_color(:green, io, " " * string(at.quantity) * "  ")
        print_with_color(:blue, io, unit * ^(" ", 5))
        at.price > 1000 ?
            print_with_color(:blue, io, string(at.price) * ^(" ", 2)) :
        at.price > 100 ?
            print_with_color(:blue, io, ^(" ", 1) * string(at.price) * ^(" ", 2)) :
        at.price > 10 ?
            print_with_color(:blue, io, ^(" ", 2) * string(at.price) * ^(" ", 2)) :
            print_with_color(:blue, io, ^(" ", 3) * string(at.price) * ^(" ", 2))
        print_with_color(:blue, io, cvar * "  ")
        print_with_color(:blue, io, string(at.asset.ticker) * "  ")
    elseif at.quantity >= 0 && unit == "contracts"
        print_with_color(:green, io, " " * string(at.quantity) * "  ")
        print_with_color(:blue, io, unit * ^(" ", 2))
        at.price > 1000 ?
            print_with_color(:blue, io, string(at.price) * ^(" ", 2)) :
        at.price > 100 ?
            print_with_color(:blue, io, ^(" ", 1) * string(at.price) * ^(" ", 2)) :
        at.price > 10 ?
            print_with_color(:blue, io, ^(" ", 2) * string(at.price) * ^(" ", 2)) :
            print_with_color(:blue, io, ^(" ", 3) * string(at.price) * ^(" ", 2))
        print_with_color(:blue, io, cvar * "  ")
        print_with_color(:blue, io, string(at.asset.ticker) * "  ")
    elseif unit == "shares"
        print_with_color(:red, io, string(at.quantity) * "  ")
        print_with_color(:blue, io, unit * ^(" ", 5))
        at.price > 1000 ?
            print_with_color(:blue, io, string(at.price) * ^(" ", 2)) :
        at.price > 100 ?
            print_with_color(:blue, io, ^(" ", 1) * string(at.price) * ^(" ", 2)) :
        at.price > 10 ?
            print_with_color(:blue, io, ^(" ", 2) * string(at.price) * ^(" ", 2)) :
            print_with_color(:blue, io, ^(" ", 3) * string(at.price) * ^(" ", 2))
        print_with_color(:blue, io, cvar * "  ")
        print_with_color(:blue, io, string(at.asset.ticker) * "  ")
    else # only contracts left here
        print_with_color(:red, io, string(at.quantity) * "  ")
        print_with_color(:blue, io, unit * ^(" ", 2))
        at.price > 1000 ?
            print_with_color(:blue, io, string(at.price) * ^(" ", 2)) :
        at.price > 100 ?
            print_with_color(:blue, io, ^(" ", 1) * string(at.price) * ^(" ", 2)) :
        at.price > 10 ?
            print_with_color(:blue, io, ^(" ", 2) * string(at.price) * ^(" ", 2)) :
            print_with_color(:blue, io, ^(" ", 3) * string(at.price) * ^(" ", 2))
        print_with_color(:blue, io, cvar * "  ")
        print_with_color(:blue, io, string(at.asset.ticker) * "  ")
    end
end
