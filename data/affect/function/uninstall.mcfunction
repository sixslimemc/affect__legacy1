#> affect:uninstall

scoreboard objectives remove -affect
scoreboard objectives remove --affect

data remove storage affect:data this
data remove storage affect:data entities
data remove storage affect:data duplicate
data remove storage affect:data registry

schedule clear affect:_/tick