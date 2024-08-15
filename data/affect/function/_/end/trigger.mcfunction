#> affect:_/end/trigger
#--------------------
# ./proxy
# _/impl/remove/each_target
#--------------------

# AS target
# with {end.trigger}
# target
# id

$data modify storage affect:var end.entity set from storage affect:data entities.active[{UUID:$(target)}]
$data modify storage affect:var end.effect_entry set from storage affect:var end.entity.effects[{id:"$(id)"}]
execute unless data storage affect:var end.effect_entry run return fail

execute if score *end.trigger.cancel_task -affect matches 1.. run data modify storage later:in cancel.task_id set from storage affect:var end.effect_entry.ending_task
execute if score *end.trigger.cancel_task -affect matches 1.. run function later:api/cancel

execute store result score *end.keep_target -affect if data storage affect:var end.entity.effects[1]

$data remove storage affect:data entities.active[{UUID:$(target)}].effects[{id:"$(id)"}]
execute if score *end.keep_target -affect matches 0 run function affect:_/end/remove_target with storage affect:var end.trigger

$data modify storage affect:var end.with.end_command set from storage affect:data registry."$(id)".end
data modify storage affect:var end.with.guuid set from storage affect:var end.entity.guuid
data modify storage affect:data current.data set from storage affect:var end.effect_entry.data
function affect:_/end/trigger.1 with storage affect:var end.with

data remove storage affect:var end
scoreboard players reset *end.keep_target -affect
scoreboard players reset *end.trigger.cancel_task -affect

return 1