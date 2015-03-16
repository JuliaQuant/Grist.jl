function settle{T<:Blotter}(b::Vector{T}, ticker::Symbol)
    # index out by ticker
    bt = b[ticker]

    # aggregate on asset class and sort
    
    # stocks (Stock, LongStock, ShortStock) 
    #stck

    # call options (LongCall, ShortCall), 
    #cll

    # put options (LongPut, ShortPut)  
    #pt

    # futures (LongFuture, ShortFuture)
    #ft
    
    # return settled blotter and un-settled blotter
    ### sb  = PnL(opened, closed, quantity, commission, pnl, financial asset)
    ### usb = Blotter(x[2].timestamp, AssetTransaction(x[2].value.quantity - 10, x[2].value.price, x[2].value.asset))    

    return sb, usb
end
