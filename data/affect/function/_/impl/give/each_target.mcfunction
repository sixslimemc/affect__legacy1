#> affect:_/impl/give/each_target
#--------------------
# @api
#--------------------

$execute store result score *give.target_exists -affect run data modify storage affect:var give.current_effects set from storage affect:data active_entities[{UUID:$(UUID)}].effects
execute if score *give.target_exists -affect matches 0 run function affect:_/impl/give/append_target

data remove storage affect:var give.targets[-1]
execute if data storage affect:var give.targets[0] run function affect:_/impl/give/each_target with storage affect:var give.targets[-1]