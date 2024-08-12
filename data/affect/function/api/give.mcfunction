#> affect:api > give
#--------------------
# -> id : AffectId
# -> duration : int
# => selector : $selector = "@s"
# => data : any = {}
#--------------------
# -> result : any
#--------------------
#> applies the affect with <id> with <data> for <duration> ticks.
#--------------------
#- see `objects.info` for information on creating affects.
#--------------------
# 0.. entities matching <selector> (success)
# -1 - <id> does not exist in {affect:data -> registry}
# -2 - <duration> is less than 1
#--------------------

# fail check
function affect:_/impl/give/get_effect with storage affect:in give
data modify storage six:in from_selector.selector set from storage affect:in give.selector
function six:api/uuid/from_selector
data modify storage affect:var give.targets set from storage six:out from_selector.result

execute store result score *give.return --affect if data storage affect:var give.targets[]
execute store result score *give.duration -affect run data get storage affect:in give.duration
execute unless data storage affect:var give.effect run scoreboard players set *give.return --affect -1
execute if score *give.duration -affect matches ..0 run scoreboard players set *give.return --affect -2>
execute unless score *give.return --affect matches 1.. run return run function affect:_/impl/give/fail

execute if data storage affect:var give.targets[0] run function affect:_/impl/give/each_target with storage affect:var give.targets[-1]
