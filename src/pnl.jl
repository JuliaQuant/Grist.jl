immutable PnL
    opened::Union(Date, DateTime)
    closed::Union(Date, DateTime)
    quantity::Int
    commission::Float64
    pnl::Float64
    asset::FinancialAsset
end
