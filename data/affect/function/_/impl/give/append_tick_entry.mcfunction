#> affect:_/impl/give/append_tick_entry
#--------------------
# ./append_effect
# ./append_target
#--------------------

data modify storage affect:var give[-1].append.effect_entry.tick.ticking set value true
data modify storage affect:var give[-1].append.effect_entry.tick.command set from storage affect:var give[-1].effect.tick
