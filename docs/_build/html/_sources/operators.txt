Operators
=========

``mark(fa::FinancialAsset, price::Float64)``
--------------------------------------------

The ``mark`` method is designed to mark to market an asset at an arbitrary interval. Typically, this is done at the end of day.

An example of its usage inside a Reactive architecture. where the arguments are of type ``Input``. 

::

    apple = lift((x,y) -> mark(x,y), apple_stock, closing_price)


``transact(fa::FinancialAsset, qty::Int, fill::Float64)``
---------------------------------------------------------

The ``transact`` method is designed to update an asset's basis and quantity based on a filled trade.

An example of its usage inside a Reactive architecture, where the arguments are of type ``Input``. 

::

    apple = lift((x,y,z) -> transact(x,y,z), apple_stock, transaction_qty, mid_price)
