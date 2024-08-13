#> affect:_/impl/give/append_target
#--------------------
# ./each_target
#--------------------


data modify storage affect:var give.append.entry.UUID set from storage affect:var give.this_target
data modify storage affect:var give.append.effect_entry.id set from storage affect:in give.id
data modify storage affect:var give.append.effect_entry.data set from storage affect:in give.data

data modify storage affect:var give.make_task.ticks set from storage affect:in give.duration
data modify storage affect:var give.make_task.data set from storage affect:in give.data
function affect:_/impl/give/make_task

data modify storage affect:var give.append.effect_entry.task set from storage later:out delay.result

data modify storage affect:var give.append.entry.effects append from storage affect:var give.append.effect_entry
data modify storage affect:data active_entities append from storage affect:data give.append.entry
