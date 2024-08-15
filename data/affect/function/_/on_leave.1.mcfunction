#> affect:_/on_leave.1

$data modify storage affect:data entities.inactive append from storage affect:data entities.active[{UUID:$(UUID)}]
$data remove storage affect:data entities.active[{UUID:$(UUID)}]