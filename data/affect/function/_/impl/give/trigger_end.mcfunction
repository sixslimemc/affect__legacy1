#> affect:_/impl/give/trigger_end
#--------------------
# ./each_target.1
#--------------------

data modify storage affect:data this append value {data:{}}
data modify storage affect:data this[-1].data set from storage affect:var give[-1].trigger_end.data
$$(end)
data remove storage affect:data this[-1]