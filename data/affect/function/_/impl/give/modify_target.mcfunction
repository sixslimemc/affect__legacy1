#> affect:_/impl/give/modify_target
#--------------------
# ./each_target
#--------------------

$data modify storage affect:var give.modify.effect set from storage affect:var give.current_effects[{id:"$(id)"}]


# get task
function affect:_/impl/give/modify_target.1 with storage affect:var give.modify.effect

# remove target from task
##data modify storage affect:var give.modify.with.current_target set from storage affect:var give.current_target
##data modify storage affect:var give.modify.with.task_id set from storage affect:var give.modify.task.task_id
##function affect:_/impl/give/modify_target.2 with storage affect:var give.modify.with
data modify storage later:in cancel.task_id set from storage affect:var give.modify.task.task_id
function later:api/cancel

# duplicate protocol
data merge storage affect:data {duplicate:{trigger_start:true}}
execute store result score *give.modify.time -affect run time query gametime
execute store result score *give.modify.old_duration -affect run data get storage affect:var give.modify.task.time
scoreboard players operation *give.modify.old_duration -affect -= *give.modify.time -affect

execute store result storage affect:data duplicate.old.duration int 1 run scoreboard players get *give.modify.old_duration -affect
data modify storage affect:data duplicate.old.data set from storage affect:var give.modify.task.data.affect._.data
data modify storage affect:data duplicate.new.duration set from storage affect:in give.duration
data modify storage affect:data duplicate.new.data set from storage affect:in give.data
data modify storage affect:data duplicate.id set from storage affect:in give.id
execute if data storage affect:var give.effect.duplicate_protocol run function affect:_/impl/give/modify_target.3 with storage affect:var give.effect
execute store result score *give.trigger_start -affect run data get storage affect:data duplicate.trigger_start

# make new task
data modify storage affect:var give.make_task.ticks set from storage affect:data duplicate.new.duration
data modify storage affect:var give.make_task.data set from storage affect:data duplicate.new.data
function affect:_/impl/give/make_task

# modify data
data modify storage affect:var give.modify.with.this_target set from storage affect:var give.this_target
data modify storage affect:var give.modify.with.id set from storage affect:in give.id
data modify storage affect:var give.modify.merge.ending_task set from storage affect:var give.make_task.result
data modify storage affect:var give.modify.merge.data set from storage affect:data duplicate.new.data
data modify storage affect:var give.modify.merge.tick.command set from storage affect:var give.effect.tick

function affect:_/impl/give/modify_target.4 with storage affect:var give.modify.with