#> affect:_/impl/give/append_effect
#--------------------
# ./modify_target
#--------------------

data modify storage affect:var give[-1].append.effect_entry.id set from storage affect:var give[-1].in
data modify storage affect:var give[-1].append.effect_entry.data set from storage affect:var give[-1].in

execute if data storage affect:var give[-1].effect.tick run function affect:_/impl/give/append_tick_entry

data modify storage affect:var give_task.ticks set from storage affect:in give.duration
function affect:_/impl/give/make_task

data modify storage affect:var give[-1].append.effect_entry.ending_task set from storage affect:var give_task.result

function affect:_/impl/give/append_effect.1 with storage affect:var give[-1]
