immutable AssetTransaction
    quantity::Int
    price::Float64
    asset::FinancialAsset
end

function show(io::IO, at::AssetTransaction)
    print(io, string(at.quantity) * "units", "    ", string(at.price) * "   " * string(at.asset.currency), "     ", at.asset.ticker)
end
