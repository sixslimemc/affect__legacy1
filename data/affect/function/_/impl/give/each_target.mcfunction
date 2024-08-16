#> affect:_/impl/give/each_target
#--------------------
# @api
#--------------------

#as snowball
kill @s
data modify storage affect:var give.this_target set from storage affect:var give.targets[-1].UUID
data modify entity @s Owner set from storage affect:var give.this_target

scoreboard players set *give.trigger_start -affect 1
data modify storage affect:var give.trigger_start.data set from storage affect:in give.data

scoreboard players set *give.trigger_end -affect 0
$execute store result score *give.target_exists -affect run data modify storage affect:var give.current_effects set from storage affect:data entities.active[{UUID:$(UUID)}].effects

execute on origin at @s run function affect:_/impl/give/each_target.1

data remove storage affect:var give.targets[-1]
execute if data storage affect:var give.targets[0] summon snowball run function affect:_/impl/give/each_target with storage affect:var give.targets[-1]