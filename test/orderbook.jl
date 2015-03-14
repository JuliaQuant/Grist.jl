facts("Orderbook type constructor works") do

    context("Good things work") do
        @fact 1 => 1
    end

    context("Bad things don't work") do
        @fact_throws Orderbook("foo") 
    end
end
