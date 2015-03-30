using MarketData # to provide mark_price

txn = Input(res[1].value)

cash = foldl(100_000.00, txn) do init, t
    init - t.quantity * t.basis
end

A = foldl(Stock(:AAPL, 0, 0.0), txn) do asset, t
    transact(asset, t.quantity, t.basis)
end

mark_price = Input(cl.values[1])

Pval = foldl(0.0, A, mark_price) do init, asset, closing_price
    asset.quantity * closing_price
end

Aval = foldl(0.0, cash, Pval) do init, c, p
    c + p
end
