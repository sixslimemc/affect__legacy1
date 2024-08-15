#> affect:_/impl/remove/each_target
#--------------------
# @api
#--------------------

data modify storage affect:var end.trigger.target set from storage affect:var remove.targets[0].UUID
data modify storage affect:var end.trigger.id set from storage affect:in remove.id
function affect:_/end/trigger with storage affect:var end.trigger

data remove storage affect:var remove.targets[0]
execute if data storage affect:var remove.targets[0] run function affect:_/impl/remove/each_target with storage affect:var remove.targets[0]