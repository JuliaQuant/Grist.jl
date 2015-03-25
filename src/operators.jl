# ~ and mark are the same method
function mark(fa::FinancialAsset, mark::Float64)
    fa.basis =  mark
end

~(fa::FinancialAsset, mark::Float64) = mark(fa::FinancialAsset, mark::Float64) 

# transact
function transact(fa::FinancialAsset, qty::Int, fill::Float64)
    fa.basis = ((fa.basis * fa.quantity) + (fill * qty)) / (fa.quantity + qty)
    fa.quantity += qty
end
