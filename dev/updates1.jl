using MarketData
const Evalue = 62140

trans = Input(res[1].value)

cash = foldl(100000.00, trans) do init, txn
    init - txn.quantity * txn.basis
end

A = foldl(Stock(:AAPL, 0, 0.0), trans) do asset, txn
    transact(asset, txn.quantity, txn.basis)
end

mark_price = Input(cl.values[1])

Pval = foldl(0.0, A, mark_price) do init, asset, closing_price
    asset.quantity * closing_price
end

Aval = foldl(0.0, cash, Pval) do init, c, p
    c + p
end
