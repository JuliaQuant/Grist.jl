using MarketData

restamp = [r.timestamp for r in res]

for i in 1:length(cl)
    if cl.timestamp[i] in restamp
        idx = findfirst(restamp, cl.timestamp[i])
        push!(trans, res[idx].value)
        push!(mark_price, cl.values[i])
    else
        push!(mark_price, cl.values[i])
    end
end
