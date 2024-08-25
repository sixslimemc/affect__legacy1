#> affect:_/impl/give/fail
#--------------------
# @api
#--------------------


data remove storage affect:in give
data remove storage affect:var give[-1]
execute unless data storage affect:var give[0] run data remove storage affect:var give
scoreboard players reset *give.duration -affect
return 0