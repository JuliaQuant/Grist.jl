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
    else
        cvar = "" 
    end

    print(io, string(at.quantity) * " " * unit, "    ",   cvar * " " * string(at.price), "     ", at.asset.ticker)
end
