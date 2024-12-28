#>affect:_/load
#--------------------
# @LOAD
#--------------------

# load
scoreboard players set *affect load-status 1

# scoreboards
scoreboard objectives add -affect dummy
scoreboard objectives add --affect dummy

# tick
schedule clear affect:_/tick
function affect:_/tick