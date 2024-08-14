#> affect:_/impl/give/modify_target.4

$data modify storage affect:data active_entities[{UUID:$(this_target)}].effects[{id:"$(id)"}] merge from storage affect:var give.modify.merge
