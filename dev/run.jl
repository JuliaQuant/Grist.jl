using MarketData

# run model without closing price updates

for i in 1:length(res)
    push!(trans, res[i].value)
end

# run model with closing price updates

# bstamp = [b.timestamp for b in res]
# 
# for i in 1:length(cl)
#     if cl.timestamp[i] in bstamp
#         idx = findfirst(bstamp, cl.timestamp[i])
#         push!(trans, res[idx].value)
#         push!(mark_price, cl.values[i])
#     else
#         push!(mark_price, cl.values[i])
#     end
# end
