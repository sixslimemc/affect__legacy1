#> affect:_/impl/give/fail
#--------------------
# @api
#--------------------

data remove storage affect:in give
data remove storage affect:var give
scoreboard players reset *give.duration -affect
return run scoreboard players get *give.return --affect