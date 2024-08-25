#> affect:_/impl/give/each_target
#--------------------
# @api
#--------------------

#as snowball
kill @s
data modify storage affect:var give[-1].this_target set from storage affect:var give[-1].targets[-1].UUID
data modify entity @s Owner set from storage affect:var give[-1].this_target

data modify storage affect:var give[-1].do_trigger set value {start:true, end:false}
data modify storage affect:var give[-1].trigger_start.data set from storage affect:var give[-1].in.data

$execute store result score *give.target_exists -affect run data modify storage affect:var give[-1].current_effects set from storage affect:data entities.active[{UUID:$(UUID)}].effects

execute on origin at @s run function affect:_/impl/give/each_target.1

data remove storage affect:var give[-1].targets[-1]
execute if data storage affect:var give[-1].targets[0] summon snowball run function affect:_/impl/give/each_target with storage affect:var give[-1].targets[-1]