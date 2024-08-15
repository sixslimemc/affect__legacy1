#> affect:api > remove
#--------------------
# -> id : AffectId
# => selector : $selector = "@s"
#--------------------
# ...
#--------------------
#> removes the effect with <id> from entities that match <selector>.
#--------------------
#- removing an effect still triggers its 'end' command.
#--------------------
# 0.. entities that matched <selector> and had the effect <id>
#--------------------

# defaults
execute unless data storage affect:in give.selector run data modify storage affect:in give.selector set value "@s"

data modify storage six:in from_selector.selector set from storage affect:in remove.selector
function six:api/uuid/from_selector
data modify storage affect:var remove.targets set from storage six:out from_selector.result

scoreboard players set *remove.return --affect 0

execute if data storage affect:var remove.targets[0] run function affect:_/impl/remove/each_target with storage affect:var remove.targets[0]

data remove storage affect:var remove
data remove storage affect:in remove

return run scoreboard players get *remove.return --affect