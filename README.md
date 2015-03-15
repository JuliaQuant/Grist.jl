Grist is a financial blotter.

Documentation is planned [here](http://gristjl.readthedocs.org/en/latest/). 

````julia
julia> Pkg.clone("https://github.com/JuliaQuant/Grist.jl.git")
````

This is a current API tour (subject to change, of course):

````julia
julia> using Grist

julia> a = LongCall(:CAT, 1.11, 115.);

julia> b = Stock(:BA, 100.11);

julia> c = Stock(:AAPL, 100.11);

julia> c.currency = EUR;

julia> foo = AssetTransaction(10, 1.12, a);

julia> bar = AssetTransaction(-100, 121.53, b);

julia> baz = AssetTransaction(10000, 121.54, c);

julia> blotterA = [Timestamp(today() - Day(15), foo), Timestamp(today() - Day(7), bar), Timestamp(today(), baz)]
3-element Array{Timestamps.Timestamp{Grist.AssetTransaction},1}:
 2015-02-28 |  10       LongCall      1.12  $    CAT 
 2015-03-08 | -100      Stock       121.53  $    BA  
 2015-03-15 |  10000    Stock       121.54  €    AAPL

julia> blotterA[:BA]
1-element Array{Timestamps.Timestamp{Grist.AssetTransaction},1}:
 2015-03-08 | -100      Stock       121.53  $    BA

julia> blotterA[EUR]
1-element Array{Timestamps.Timestamp{Grist.AssetTransaction},1}:
 2015-03-15 |  10000    Stock       121.54  €    AAPL
````

Travis, Coveralls and PackageEvaluator are stubbed below:

[![Build Status](https://travis-ci.org/JuliaQuant/Grist.jl.png)](https://travis-ci.org/JuliaQuant/Grist.jl)
[![Coverage Status](https://coveralls.io/repos/JuliaQuant/Grist.jl/badge.png?branch=master)](https://coveralls.io/r/JuliaQuant/Grist.jl?branch=master)
[![Grist](http://pkg.julialang.org/badges/Grist_release.svg)](http://pkg.julialang.org/?pkg=Grist&ver=release)
