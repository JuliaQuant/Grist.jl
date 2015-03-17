function settle{T<:Blotter}(b::Vector{T}, ticker::Symbol)
    # index out by ticker
    bt = b[ticker]

    # aggregate on asset class and sort
    
    # stocks (Stock, LongStock, ShortStock) 
    vs   = [Stock, LongStock, ShortStock]
    stck = b[vs]

    # call options (LongCall, ShortCall), 
    vc  = [LongCall, ShortCall]
    cll = b[vc]

    # put options (LongPut, ShortPut)  
    vp = [LongPut, ShortPut]
    pt = b[vp]

    # futures (LongFuture, ShortFuture)
    vf = [LongFuture, ShortFuture]
    ft = b[vf]
    
    # return settled blotter and un-settled blotter
    ### sb  = PnL(opened, closed, quantity, commission, pnl, financial asset)
    ### usb = Blotter(x[2].timestamp, AssetTransaction(x[2].value.quantity - 10, x[2].value.price, x[2].value.asset))    

    return sb, usb
end
