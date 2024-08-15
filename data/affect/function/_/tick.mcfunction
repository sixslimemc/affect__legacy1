#>affect:_/tick
#--------------------
# @TICK
#--------------------

schedule function affect:_/tick 1t

data modify storage affect:var ticking.entities set from storage affect:data entities.active
execute if data storage affect:var ticking.entities[0] run function affect:_/ticking/each_entity

data remove storage affect:var ticking
