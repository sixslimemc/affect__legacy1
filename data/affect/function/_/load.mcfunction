#>affect:_/load
#--------------------
# @LOAD
#--------------------

# load
scoreboard players set *affect load-status 1

# settings
execute unless data storage affect:settings {PERSIST:true} run function affect:settings

#declare storage affect:var
#declare storage affect:in
#declare storage affect:out
#declare storage affect:data
#declare storage affect:hook
#declare storage affect:implement

# scoreboards
scoreboard objectives add -affect dummy
scoreboard objectives add --affect dummy
#scoreboard objectives add affect-scoreboard dummy

# tick
schedule clear affect:_/tick
function affect:_/tick