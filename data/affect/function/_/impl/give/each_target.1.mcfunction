#> affect:_/impl/give/each_target.1



execute if score *give.target_exists -affect matches 0 run function affect:_/impl/give/append_target
execute if score *give.target_exists -affect matches 1.. run function affect:_/impl/give/modify_target with storage affect:in give

execute if score *give.trigger_start -affect matches 1.. if data storage affect:var give.effect.start run function affect:_/impl/give/trigger_start with storage affect:var give.effect