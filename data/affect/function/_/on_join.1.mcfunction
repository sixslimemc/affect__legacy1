#> affect:_/on_join.1

$data modify storage affect:data entities.active append from storage affect:data entities.inactive[{UUID:$(UUID)}]
$data remove storage affect:data entities.inactive[{UUID:$(UUID)}]