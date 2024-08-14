#> affect:_/end/remove_effect
#--------------------
# ./proxy
#--------------------


$execute store result score *end.removed -affect run data remove storage affect:data active_entities[{UUID:$(target)}].effects[{id:"$(id)"}]

