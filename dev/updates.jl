trans = Input(res[1].value)

qty  = Input(0)
fill = Input(0.0)

qty  = lift((x,y) -> x.quantity + y, trans, qty)
fill = lift((x,y) -> x.basis+ y, trans, fill)

A = Input(Stock(:AAPL, 0, 0.0))

qf = Input((0, 0.00)) # tuple of qty and fill
qf = lift((x,y) -> (x,y), qty,fill)

lift(A,qf) do fa, t
    q,f = t
    transact(fa,q,f)
end

Cash = Input(100000.00)

Cash = lift(Cash, trans) do c,t
    Cash.value - (t.quantity * t.basis)
end

Mark = Input(0.0) # just starting with Closing price
PValue = Input(0.0) # needs to be an array

Pvalue = lift(Pvalue, A, Mark) do pv, a, m
    pv = a.quantity * m
end

Account = Input(0.0)

Account = lift(Account, Pvalue, Cash) do a,p,v
    a = p + v
end

using MarketData

for i in 1:length(cl)
    for j in 1:length(res)
        if res[j].timestamp == cl[1].timestamp
            push!(trans, res[j].value)
            push!(Mark, cl.values[i])
        else
            push!(Mark, cl.values[i])
        end
    end
end

# update process involves pushing trans and Mark

# push!(trans, res[2].value) etc.

# for r in 1:length(res)
#     push!(trans, res[r].value)
# end
