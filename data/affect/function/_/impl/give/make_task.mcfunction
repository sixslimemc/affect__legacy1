#> affect:_/impl/give/make_task
#--------------------
# ./append_target
#--------------------

data modify storage later:in delay.ticks set from storage affect:in give.make_task.ticks
data modify storage later:in delay.command set value "function affect:_/end/proxy with storage later:data current.data.affect._"
data modify storage later:in delay.selector set from storage affect:in give.selector
data modify storage later:in delay.data.affect._.end_command set from storage affect:var give.effect.end
data modify storage later:in delay.data.affect._.target set from storage affect:var give.this_target
data modify storage later:in delay.data.affect._.data set from storage affect:in give.make_task.data
data modify storage later:in delay.data.affect._.id set from storage affect:in give.id
function later:api/delay
function later.prt:api/enable