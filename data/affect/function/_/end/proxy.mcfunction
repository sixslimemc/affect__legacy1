#> affect:_/end/proxy
#--------------------
# @later:delayed : _/impl/give/append_target
#--------------------

$data modify storage affect:var end.entity set from storage affect:data active_entities[{UUID:$(target)}]
data modify storage affect:data current.data set from storage later:data current.data.affect.data

# remove entity entry on api/remove
execute store result score *end.keep_target -affect if data storage affect:var end.entity.effects[1]

function affect:_/end/remove_effect with storage later:data current.data.affect._
execute if score *end.keep_target -affect matches 0 run function affect:_/end/remove_target with storage later:data current.data.affect._

$execute if score *end.removed -affect matches 1.. run $(end_command)

data remove storage affect:var end
scoreboard players reset *end.removed -affect
scoreboard players reset *end.keep_target -affect