# transact helper method

function transact(fa::FinancialAsset, qty::Int, fill::Float64)
    if fa.quantity + qty == 0
        fa.basis = 0 
        fa.quantity = 0
    else
        fa.basis = ((fa.basis * fa.quantity) + (fill * qty)) / (fa.quantity + qty)
        fa.quantity += qty
    end
    fa
end
