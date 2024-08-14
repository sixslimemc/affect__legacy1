#> affect:_/ticking/each_entity
#--------------------
# _/tick
#--------------------

data modify storage affect:var ticking.this_entity set from storage affect:var ticking.entities[-1]

data merge storage affect:var {ticking:{effects:[]}}
data modify storage affect:var ticking.effects append from storage affect:var ticking.this_entity.effects[{tick:{ticking:true}}]

execute if data storage affect:var ticking.effects[0] run function affect:_/ticking/each_effect

data remove storage affect:var ticking.entities[-1]
execute if data storage affect:var ticking.entities[0] run function affect:_/ticking/each_entity