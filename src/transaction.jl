immutable AssetTransaction
    quantity::Int
    price::Float64
    asset::FinancialAsset

    # assign quantity to financial asset object
    # this is important because the object carries this info in its fields
    # downstream the financial asset can be extracted for settlement

    function AssetTransaction(quantity::Int, price::Float64, asset::FinancialAsset)
        if typeof(asset) == Stock || typeof(asset) == LongStock || typeof(asset) == ShortStock
            asset.shares = quantity 
        else
            asset.contracts = quantity
        end
        new(quantity, price, asset) 
    end
end

function show(io::IO, at::AssetTransaction)

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
    unit = split(string(typeof(at.asset)), ".")[2]  # asset type as a string

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

    if at.quantity >= 0 
        print_with_color(:green, io, " " * string(at.quantity) * ^(" ", q_len - strwidth(string(at.quantity)))) 
        print_with_color(:blue, io, unit * ^(" ", u_len - strwidth(unit)))
        print_with_color(:blue, io, ^(" ", p_len - strwidth(string(at.price)))  * string(at.price) * "  ") # rpad fixed at two spaces
        print_with_color(:blue, io, cvar * ^(" ", c_len - strwidth(cvar)))
        print_with_color(:blue, io, string(at.asset.ticker))
    else at.quantity < 0 
        print_with_color(:red, io, string(at.quantity) * ^(" ", q_len - strwidth(string(at.quantity)) + 1))  # the +1 for negative value padding
        print_with_color(:blue, io, unit * ^(" ", u_len - strwidth(unit)))
        print_with_color(:blue, io, ^(" ", p_len - strwidth(string(at.price)))  * string(at.price) * "  ") # rpad fixed at two spaces
        print_with_color(:blue, io, cvar * ^(" ", c_len - strwidth(cvar)))
        print_with_color(:blue, io, string(at.asset.ticker))
    end
end

### this is wrong, you don't add transactions
### function +(a1::AssetTransaction, a2::AssetTransaction)
###     typ = typeof(a1.asset)
### 
###     if a1.asset.ticker != a2.asset.ticker # check ticker
###         error("underlying assets must match.")
###     elseif typeof(a1.asset) != typeof(a2.asset) # check similar financial asset types
###         error("only like asset types supported")
###     else
###         PnL()
###     opened::Union(Date, DateTime)
###     closed::Union(Date, DateTime)
###     quantity::Int
###     commission::Float64
###     pnl::Float64
###     asset::FinancialAsset
###     end
### end
