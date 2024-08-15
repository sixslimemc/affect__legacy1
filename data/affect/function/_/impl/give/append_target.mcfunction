#> affect:_/impl/give/append_target
#--------------------
# ./each_target
#--------------------

data modify storage affect:var give.append.entry.UUID set from storage affect:var give.this_target
data modify storage six:in guuid.UUID set from storage affect:var give.this_target
function six:api/uuid/guuid
data modify storage affect:var give.append.entry.guuid set from storage six:out guuid.result
data modify storage affect:var give.append.effect_entry.id set from storage affect:in give.id
data modify storage affect:var give.append.effect_entry.data set from storage affect:in give.data

execute if data storage affect:var give.effect.tick run function affect:_/impl/give/append_tick_entry

data modify storage affect:var give.make_task.ticks set from storage affect:in give.duration
data modify storage affect:var give.make_task.data set from storage affect:in give.data
function affect:_/impl/give/make_task

data modify storage affect:var give.append.effect_entry.ending_task set from storage affect:var give.make_task.result

data modify storage affect:var give.append.entry.effects append from storage affect:var give.append.effect_entry

## prepended for tick performance
data modify storage affect:data entities.active prepend from storage affect:var give.append.entry
