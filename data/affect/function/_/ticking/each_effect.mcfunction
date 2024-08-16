#> affect:_/ticking/each_effect
#--------------------
# ./each_entity
#--------------------

data modify storage affect:var ticking.this_effect set from storage affect:var ticking.effects[-1]
data modify storage affect:var ticking.with.guuid set from storage affect:var ticking.entities[-1].guuid

data modify storage affect:data current.data set from storage affect:var ticking.this_effect.data
data modify storage affect:var ticking.with.command set from storage affect:var ticking.this_effect.tick.command
function affect:_/ticking/each_effect.1 with storage affect:var ticking.with

data remove storage affect:var ticking.effects[-1]
execute if data storage affect:var ticking.effects[0] run function affect:_/ticking/each_effect