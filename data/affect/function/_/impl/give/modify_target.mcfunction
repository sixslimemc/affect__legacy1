#> affect:_/impl/give/modify_target
#--------------------
# ./each_target
#--------------------

$data modify storage affect:var give.modify.effect set from storage affect:var give.current_effects[{id:"$(id)"}]

function affect:_/impl/give/modify_target.1 with storage affect:var give.modify.effect

execute store result score *give.modify.time -affect run time query gametime
execute store result score *give.modify.old_duration -affect run data get storage affect:var give.modify.task.time
scoreboard players operation *give.modify.old_duration -affect -= *give.modify.time -affect

execute store result storage affect:data duplicate.old.duration int 1 run scoreboard players get *give.modify.old_duration -affect
data modify storage affect:data duplicate.old.data set from storage affect:var give.modify.task.data.affect._.data
data modify storage affect:data duplicate.new.duration set from storage affect:in give.duration
data modify storage affect:data duplicate.new.data set from storage affect:in give.data

# DEV - REMOVE TARGET FROM TASK HERE
function affect:_/impl/give/modify_target.2 with storage affect:var give.effect

data modify storage affect:var give.modify.target set from storage affect:var give.this_target
data modify storage affect:var give.modify.id set from storage affect:in give.id
