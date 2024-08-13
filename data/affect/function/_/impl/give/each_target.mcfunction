#> affect:_/impl/give/each_target
#--------------------
# @api
#--------------------

data modify storage affect:var give.this_target set from storage affect:var give.targets[-1].UUID

$execute store result score *give.target_exists -affect run data modify storage affect:var give.current_effects set from storage affect:data active_entities[{UUID:$(UUID)}].effects
execute if score *give.target_exists -affect matches 0 run function affect:_/impl/give/append_target
execute if score *give.target_exists -affect matches 1.. run function affect:_/impl/give/modify_target with storage affect:in give

data remove storage affect:var give.targets[-1]
execute if data storage affect:var give.targets[0] run function affect:_/impl/give/each_target with storage affect:var give.targets[-1]