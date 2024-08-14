#> affect:_/impl/give/append_tick_entry
#--------------------
# ./append_effect
# ./append_target
#--------------------

data merge storage affect:var {give:{append:{effect_entry:{tick:{ticking:true}}}}}
data modify storage affect:var give.append.effect_entry.tick.command set from storage affect:var give.effect.tick
