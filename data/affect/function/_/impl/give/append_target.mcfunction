#> affect:_/impl/give/append_target
#--------------------
# ./each_target
#--------------------

data modify storage later:in delay.ticks set from storage affect:in give.duration
data modify storage later:in delay.command set value "function affect:_/end/proxy with storage later:data current.data.affect"
data modify storage later:in delay.selector set from storage affect:in give.selector
data modify storage later:in delay.data.affect.end_command set from storage affect:var give.effect.end
data modify storage later:in delay.data.affect.target set from storage affect:var give.targets[-1].UUID
data modify storage later:in delay.data.affect.id set from storage affect:in give.id
function later:api/delay
function later.prt:api/enable