#> affect:_/end/trigger
#--------------------
# ./proxy
# _/impl/remove/each_target
#--------------------

# AS target
# with {end.trigger}
# target
# id

$data modify storage affect:var end.entity set from storage affect:data active_entities[{UUID:$(target)}]
$data modify storage affect:var end.effect_entry set from storage affect:var end.entity.effects[{id:"$(id)"}]


execute store result score *end.trigger.keep_target -affect if data storage affect:var end.entity.effects[1]

$data remove storage affect:data active_entities[{UUID:$(target)}].effects[{id:"$(id)"}]
execute if score *end.keep_target -affect matches 0 run function affect:_/end/remove_target with storage affect:var end.trigger

$data modify storage affect:var end.with.end_command set from storage affect:data registry."$(id)".end
data modify storage affect:var end.with.guuid set from storage affect:var end.entity.guuid
data modify storage affect:data current.data set from storage affect:var end.effect_entry.data
function affect:_/end/trigger.1 with storage affect:var end.with

data remove storage affect:var end.trigger
scoreboard players reset *end.trigger.keep_target -affect