using Grist, MarketData

rng = 1:50:500

apple1  = Stock(:AAPL, cl.values[rng[1]], 100)
apple2  = Stock(:AAPL, cl.values[rng[2]], -100)
apple3  = Stock(:AAPL, cl.values[rng[3]], 100)
apple4  = Stock(:AAPL, cl.values[rng[4]], -100)
apple5  = Stock(:AAPL, cl.values[rng[5]], 100)
apple6  = Stock(:AAPL, cl.values[rng[6]], -100)
apple7  = Stock(:AAPL, cl.values[rng[7]], 100)
apple8  = Stock(:AAPL, cl.values[rng[8]], -100)
apple9  = Stock(:AAPL, cl.values[rng[9]], 100)
apple10 = Stock(:AAPL, cl.values[rng[10]], -100)

port = [apple1, 
        apple2, 
        apple3, 
        apple4, 
        apple5, 
        apple6, 
        apple7, 
        apple8, 
        apple9, 
        apple10] 

dts = [cl.timestamp[rng[1]],
       cl.timestamp[rng[2]],
       cl.timestamp[rng[3]],
       cl.timestamp[rng[4]],
       cl.timestamp[rng[5]],
       cl.timestamp[rng[6]],
       cl.timestamp[rng[7]],
       cl.timestamp[rng[8]],
       cl.timestamp[rng[9]],
       cl.timestamp[rng[10]]]

res = Timestamp[]

for d in 1:10
push!(res, Timestamp(dts[d], port[d]))
end

vals = zeros(10);

for r in 1:10
    #vals[r] = -1*(res[r].value.quantity * res[r].value.basis)
    vals[r] = res[r].value.quantity * res[r].value.basis
end
