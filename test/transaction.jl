facts("AssetTransaction type constructor works") do

    context("Good things work") do
        @fact 1 => 1
    end

    context("Bad things don't work") do
        @fact_throws AssetTransaction("foo") 
    end
end
