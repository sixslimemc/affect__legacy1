#> affect:_/impl/give/append_effect
#--------------------
# ./modify_target
#--------------------

data modify storage affect:var give.append.effect_entry.id set from storage affect:in give.id
data modify storage affect:var give.append.effect_entry.data set from storage affect:in give.data

execute if data storage affect:var give.effect.tick run function affect:_/impl/give/append_tick_entry

data modify storage affect:var give.make_task.ticks set from storage affect:in give.duration
function affect:_/impl/give/make_task

data modify storage affect:var give.append.effect_entry.ending_task set from storage affect:var give.make_task.result

function affect:_/impl/give/append_effect.1 with storage affect:var give