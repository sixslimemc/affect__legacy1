#> affect:_/impl/give/each_target.1

execute if score *give.target_exists -affect matches 0 run function affect:_/impl/give/append_target
execute if score *give.target_exists -affect matches 1.. run function affect:_/impl/give/modify_target with storage affect:var give[-1].in

execute if data storage affect:var give[-1].do_trigger{end:true} if data storage affect:var give[-1].effect.end run function affect:_/impl/give/trigger_end with storage affect:var give[-1].effect
execute if data storage affect:var give[-1].do_trigger{start:true} if data storage affect:var give[-1].effect.start run function affect:_/impl/give/trigger_start with storage affect:var give[-1].effect