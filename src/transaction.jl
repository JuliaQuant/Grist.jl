immutable AssetTransaction
    quantity::Int
    price::Float64
    asset::FinancialAsset
end

function show(io::IO, at::AssetTransaction)
    # window size for column alignment

    # quantity max out at 1_000_000, ergo = 9 (7 + 2 for min spacing)
    q_len = 9
    # shares || contracts, ergo = 11 (9 + 2)
    u_len = 11
    # price max out at  9999.99, ergo = 9 (7 + 2)
    p_len = 9
    # currency max out at AU$ = 5 (3 + 2)
    c_len = 5

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

    if at.quantity >= 0 
        print_with_color(:green, io, " " * string(at.quantity) * ^(" ", q_len - strwidth(string(at.quantity)))) 
        print_with_color(:blue, io, unit * ^(" ", u_len - strwidth(unit)))
        print_with_color(:blue, io, string(at.price) * ^(" ", p_len - strwidth(string(at.price))))
        print_with_color(:blue, io, cvar * ^(" ", c_len - strwidth(cvar)))
        print_with_color(:blue, io, string(at.asset.ticker))
    else at.quantity < 0 
        print_with_color(:red, io, string(at.quantity) * ^(" ", q_len - strwidth(string(at.quantity)) + 1))  # the +1 for negative value padding
        print_with_color(:blue, io, unit * ^(" ", u_len - strwidth(unit)))
        print_with_color(:blue, io, string(at.price) * ^(" ", p_len - strwidth(string(at.price))))
        print_with_color(:blue, io, cvar * ^(" ", c_len - strwidth(cvar)))
        print_with_color(:blue, io, string(at.asset.ticker))
    end
end
