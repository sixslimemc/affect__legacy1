#> affect:_/impl/remove/each_target
#--------------------
# @api
#--------------------

data modify storage affect:var end.trigger.target set from storage affect:var remove.targets[0]
data modify storage affect:var end.trigger.id set from storage affect:in remove.id
scoreboard players set *end.trigger.cancel_task -affect 1

execute store result score *remove.success -affect run function affect:_/end/trigger with storage affect:var end.trigger

scoreboard players operation *remove.return --affect += *remove.success -affect

data remove storage affect:var remove.targets[0]
execute if data storage affect:var remove.targets[0] run function affect:_/impl/remove/each_target