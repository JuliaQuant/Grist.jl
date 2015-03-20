Grist is a financial blotter.

Documentation is planned [here](http://gristjl.readthedocs.org/en/latest/). 

````julia
julia> Pkg.clone("https://github.com/JuliaQuant/Grist.jl.git")
````

This is a current API tour (subject to change, of course):

````julia
julia> using Grist

julia> a = LongCall(:CAT, 1.11, 115.);

julia> a.quantity = 100
100

julia>  b = Stock(:BA, 100.11);

julia> b.quantity = 1000
1000

julia> c = Stock(:AAPL, 102);

julia> c.currency = EUR;

julia> c.quantity = -100;

julia> d = Date(2015,3,12);

julia> foo = Timestamp(d - Day(15), a);

julia> bar = Timestamp(d - Day(7), b);

julia> baz = Timestamp(d , c)
2015-03-12 | -100      Stock         102.0   €    AAPL

julia>  res = [foo, bar, baz]
3-element Array{Timestamps.Timestamp{T},1}:
 2015-02-25 |  100      LongCall        1.11  $    CAT 
 2015-03-05 |  1000     Stock         100.11  $    BA  
 2015-03-12 | -100      Stock         102.0   €    AAPL

julia> res[:BA]
1-element Array{Timestamps.Timestamp{T},1}:
 2015-03-05 |  1000     Stock         100.11  $    BA

julia>  res[LongCall]
1-element Array{Timestamps.Timestamp{T},1}:
 2015-02-25 |  100      LongCall        1.11  $    CAT

julia> res[EUR]
1-element Array{Timestamps.Timestamp{T},1}:
 2015-03-12 | -100      Stock         102.0   €    AAPL

julia> res[d-Day(14):d]
2-element Array{Timestamps.Timestamp{T},1}:
 2015-03-05 |  1000     Stock         100.11  $    BA  
 2015-03-12 | -100      Stock         102.0   €    AAPL
````
