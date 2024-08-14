#> affect:_/impl/give/modify_target
#--------------------
# ./each_target
#--------------------

$execute store result score *give.is_duplicate -affect run data modify storage affect:var give.modify.effect set from storage affect:var give.current_effects[{id:"$(id)"}]

execute if score *give.is_duplicate -affect matches 1.. run function affect:_/impl/give/duplicate
execute if score *give.is_duplicate -affect matches 0 run function affect:_/impl/give/append_effect
