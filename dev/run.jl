using MarketData
export simulate

# run model without closing price updates

# convert TimeArray to Timestamps array
clt = Timestamp[]

for i in 1:length(cl)
    push!(clt, Timestamp(cl[i].timestamp[1], cl[i].values[1])) 
end

cr = vcat(res, clt) # combine both arrays with txn array first
sd = sort(Date[c.timestamp for c in cr]) # get dates and sort
ud = unique(sd) # remove duplicates

mixed_array = cr[ud[1]] # initialize array to be pushed

for i in 2:length(ud)
    mixed_array = vcat(mixed_array, cr[ud[i]])
end

# this takes mixed_array and updates the following
# txn & mark_price explicity
# A, Pval, Aval by association

function simulate(tsv::Vector{Timestamp})
    for t in 1:length(tsv)
        if typeof(tsv[t].value) <: FinancialAsset
            push!(txn, tsv[t].value)
        elseif typeof(tsv[t].value) == Float64
            push!(mark_price, tsv[t].value)
        else
            error("rogue timestamp in your midst!")
        end
    end
end
