#> affect:_/impl/give/make_task
#--------------------
# ./append_target
# ./append_effect
#--------------------

data merge storage later:in {delay:{selector:"@s", command:"function affect:_/end/proxy", failsafe:"function affect:_/end/failsafe with storage later:data current"}}
data modify storage later:in delay.ticks set from storage affect:var give_task.ticks
data modify storage later:in delay.data.affect._.end_command set from storage affect:var give[-1].effect.end
data modify storage later:in delay.data.affect._.target set from storage affect:var give[-1].this_target
data modify storage later:in delay.data.affect._.id set from storage affect:var give[-1].in.id

function later:api/delay
data modify storage affect:var give_task.result set from storage later:out delay.result

function later.prt:api/enable