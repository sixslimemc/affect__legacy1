#> affect:_/impl/give/duplicate
#--------------------
# ./modify_target
#--------------------

# get task
function affect:_/impl/give/duplicate.1 with storage affect:var give[-1].modify.effect

# remove target from task
##data modify storage affect:var give[-1].modify.with.current_target set from storage affect:var give.current_target
##data modify storage affect:var give[-1].modify.with.task_id set from storage affect:var give[-1].modify.task.task_id
##function affect:_/impl/give/modify_target.2 with storage affect:var give[-1].modify.with
data modify storage later:in cancel.task_id set from storage affect:var give[-1].modify.task.task_id
function later:api/cancel

# duplicate protocol
data modify storage affect:data duplicate append value {old:{trigger_end:true}, new:{trigger_start:true}}
execute store result score *give.modify.time -affect run time query gametime
execute store result score *give.modify.old_duration -affect run data get storage affect:var give[-1].modify.task.time
scoreboard players operation *give.modify.old_duration -affect -= *give.modify.time -affect

execute store result storage affect:data duplicate[-1].old.duration int 1 run scoreboard players get *give.modify.old_duration -affect
data modify storage affect:data duplicate[-1].old.data set from storage affect:var give[-1].modify.effect.data
data modify storage affect:data duplicate[-1].new.duration set from storage affect:var give[-1].in.duration
data modify storage affect:data duplicate[-1].new.data set from storage affect:var give[-1].in.data
data modify storage affect:data duplicate[-1].id set from storage affect:var give[-1].in.id
execute if data storage affect:var give[-1].effect.duplicate_protocol run function affect:_/impl/give/duplicate.2 with storage affect:var give[-1].effect

data modify storage affect:var give[-1].do_trigger.start set from storage affect:data duplicate[-1].new.trigger_start
execute if data storage affect:var give[-1].do_trigger{start:true} run data modify storage affect:var give[-1].trigger_start.data set from storage affect:data duplicate[-1].new.data

data modify storage affect:var give[-1].do_trigger.end set from storage affect:data duplicate[-1].old.trigger_end
execute if data storage affect:var give[-1].do_trigger{end:true} run data modify storage affect:var give[-1].trigger_end.data set from storage affect:data duplicate[-1].old.data

# make new task
#>---- D E B U G --------
data modify storage loggr:in log.message set from storage affect:data duplicate
function loggr:api/log
#>--------------

data modify storage affect:var give_task.ticks set from storage affect:data duplicate[-1].new.duration
function affect:_/impl/give/make_task


# modify data
data modify storage affect:var give[-1].modify.with.this_target set from storage affect:var give[-1].this_target
data modify storage affect:var give[-1].modify.with.id set from storage affect:var give[-1].in.id
data modify storage affect:var give[-1].modify.merge.ending_task set from storage affect:var give_task.result
data modify storage affect:var give[-1].modify.merge.data set from storage affect:data duplicate[-1].new.data
data modify storage affect:var give[-1].modify.merge.tick.command set from storage affect:var give[-1].effect.tick

function affect:_/impl/give/duplicate.3 with storage affect:var give[-1].modify.with

data remove storage affect:data duplicate[-1]