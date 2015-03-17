function settle{T<:Blotter}(b::Vector{T})
    ###  array of tickers
    ###  syms  = Symbol[s.value.asset.ticker for s in b]
    ###  iterate across this array with call to method below
end

function settle{T<:Blotter}(b::Vector{T}, ticker::Symbol)
    # index out by ticker
    
    bt = b[ticker]

    # aggregate on asset class and sort
    
    # stocks (Stock, LongStock, ShortStock) 
    vs   = [Stock, LongStock, ShortStock]
    stck = bt[vs]

    # call options (LongCall, ShortCall), 
    vc  = [LongCall, ShortCall]
    cll = bt[vc]

    # put options (LongPut, ShortPut)  
    vp  = [LongPut, ShortPut]
    pt  = bt[vp]

    # futures (LongFuture, ShortFuture)
    vf  = [LongFuture, ShortFuture]
    ft  = bt[vf]
    
    # return settled blotter and un-settled blotter
    ### sb  = PnL(opened, closed, quantity, commission, pnl, financial asset)
    ### usb = Blotter(x[2].timestamp, AssetTransaction(x[2].value.quantity - 10, x[2].value.price, x[2].value.asset))    

    return sb, usb
end
## function settle{T<:(Blotter.Stock, LongStock, ShortStock)}(b::Vector{T}
## end
