# #calculate expected value
# tst = Float64[]
# 
# for i in 1:length(res)
#     push!(txn, res[i].value)
#     push!(tst, txn.value.quantity * txn.value.basis)
# end
# 
# eq = 100_000.00
# for t in tst
#     eq -= t
# end
# 
# const Eval = eq # 96214.00

facts("AssetTransaction type constructor works") do

    context("Good things work") do
        @fact 1 => 1
    end

    context("Bad things don't work") do
        @fact_throws AssetTransaction("foo") 
    end
end
