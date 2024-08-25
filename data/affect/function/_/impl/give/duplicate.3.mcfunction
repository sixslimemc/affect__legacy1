#> affect:_/impl/give/modify_target.4

$data modify storage affect:data entities.active[{UUID:$(this_target)}].effects[{id:"$(id)"}] merge from storage affect:var give[-1].modify.merge

# data has to be set. bruh moment
$data modify storage affect:data entities.active[{UUID:$(this_target)}].effects[{id:"$(id)"}].data set from storage affect:var give[-1].modify.merge.data