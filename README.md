
# Affect | affect
> Library that makes implementing effect-like behavior dead-simple.

## Dependencies
- [load](https://github.com/sixslime/load)
- [six](https://github.com/sixslime/six)
- [onjoin](https://github.com/sixslime/onjoin)
- [onleave](https://github.com/sixslime/onleave)
- [later](https://github.com/sixslime/later)
- [later.prt](https://github.com/sixslime/later.prt)

# Overview
Affect provides an API/framework for defining command-driven custom entity effects (referred to as 'c-effects' for brevity).

C-effect definitions have the following components:
- `start`: Command that runs when c-effect is applied, before the first tick of being active.
- `tick`: Command that runs every tick while the c-effect is active.
- `end`: Command that runs immediately after the c-effect wears off or is removed.
- `duplicate_protocol`: Command that handles the logic when a c-effect is applied but is already present on the entity.

In addition to having a duration, c-effect instances can have arbitrary data attached, which is accessible to all of a c-effects components.
# Usage
For brevity, NBT storage locations will be referred to like so: `<storage location> -> <nbt path>`. \
*Such that `/data modify storage <storage location> <nbt location>...` is valid.* 

Likewise, custom effects created with Affect will be referred to as 'c-effects'.
### Conceptual
A c-effect has one **definition** that defines it's behavior (the four components described above.)

Once a c-effect is defined, it can be applied to an entity, creating an **instance** of that c-effect. \
An instance of a c-effect has a duration, and can optionally have attached data, accessible by it's components.

An entity **cannot** have multiple instances of the same c-effect.

If a c-effect is applied to an entity that already has an instance of the same c-effect active, that c-effect's `duplicate_protocol` is executed, which handles how the two instances are merged.

### Defining Effects
#### Effect Identifiers
A c-effect must have an EffectIdentifier, which effectively acts as it's name. \
An EffectIdentifier must be in a format similar to NBT storage locations: **`<namespace>:<arbitrary path>`**. \
*(ex: `mypack:some_category/my_effect`.)* \
By convention, `<namespace>` must be the namespace that the c-effect is being defined in.

#### Effect Definition
To define a c-effect, add an object under `affect:data -> registry.<EffectIdentifier>` with the following keys:
| NBT path | Type | Description |
|--|--|--|
| `start` | string (command) | Command that runs when c-effect is applied, before the first tick of being active. |
| `tick` | string (command) | Command that runs every tick while the c-effect is active. |
| `end` | string (command) | Command that runs immediately after the c-effect wears off or is removed. |
| `duplicate_protocol` | string (command) | Command that handles the logic when a c-effect is applied but is already present on the target (See Duplicate Protocol). |

Any key may be omitted if no command is desired for the given key. \
(ex: if `end` is omitted, the c-effect will not run any command when it wears off.)

It is standard to put c-effect definitions in or in a sub-function of a datapack's load function. \
It is recommended that datapacks remove their c-effect definitions in an "uninstall" function.

#### Effect Implementation
As stated above, `start`, `tick`, and `end` are simply commands that will run during stages of a c-effect instance's lifetime. \
*For non-trivial uses, these will probably contain a `function` command.*

ALL components/commands of a c-effect will run AS and AT the entity they effect.

If a c-effect instance is provided with data, `affect:data -> this[-1].data` will hold this data when the `start`, `tick`, and `end` commands are executed.

Once a c-effect instance is applied with data, this data cannot change; another instance must be applied in order for it to change. \
*(Changes made to `affect:data -> this[-1].data` are ignored.)*

#### Duplicate Protocol

The `duplicate_protocol` is a command that is executed when a c-effect is applied to an entity that already has an instance of the same c-effect, and handles how the two instances are merged.

Upon `duplicate_protocol` execution, `affect:data -> duplicate[-1]` will hold the following keys:
| NBT path | Type | Description |
|--|--|--|
| `id` | string (EffectIdentifier) [readonly] | The EffectIdentifier of the duplicate c-effect. |
| `old.data` | any [readonly] | The data of the old instance. |
| `old.duration` | int [readonly] | The remaining duration of the old instance. |
| `new.data` | any | The data of the new instance. |
| `new.duration` | int | The duration of the new instance. |
| `trigger.start` | bool | Whether or not to trigger the `start` of the new instance. (defaults true) |
| `trigger.end` | bool | Whether or not to trigger the `end` of the old instance. (defaults true) |

After `duplicate_protocol` is finished executing, the entity's c-effect instance is updated to reflect `affect:data -> duplicate[-1].new`. \
As stated above, `affect:data -> duplicate[-1].trigger` dictates whether or not `start`/`end` is triggered for the new/old instance.

Notice that if `duplicate_protocol` does nothing, the behavior is equivalent to removing the old instance then applying the new one.

### Giving/Removing Effects
It is important to note that `affect:api/...` functions reset their input values after use. \
This has the side effect of making `execute as <multi-entity selector> run function affect:api/...` ineffective, as the inputs are reset after executing as the first entity. \
*(Hence why `affect:api/...` functions have the 'selector' input.)*

#### Giving Effects
To give entities a c-effect, use `affect:api/give` with the following inputs under `affect:in -> give`:
| NBT path | Type | Default Value |
|--|--|--|
| `id` | string (EffectIdentifier) | *(none)* |
| `duration` | int | *(none)* |
| `selector` | string (selector) | "@s" |
| `data` | any | {} |

This gives entities captured by **\<selector\>** the c-effect **\<id\>** for **\<duration\>** ticks, with **\<data\>** attached.

This function has the following return codes:
- `0..` : How many entities matched **\<selector\>** (success).
- `-1` : **\<id\>** does not exist within `affect:data -> registry`.
- `-2` : **\<duration\>** is less than 1.

#### Removing Effects
To remove a c-effect from entities, use `affect:api/remove` with the following inputs under `affect:in -> remove`:
| NBT path | Type | Default Value |
|--|--|--|
| `id` | string (EffectIdentifier) | *(none)* |
| `selector` | string (selector) | "@s" |

This removes any instances of the **\<id\>** c-effect from entities matching **\<selector\>**.

This function will return the amount of c-effect instances removed.

## Examples

### Create a simple effect:

Defines `mypack:on_fire`, which gives 20% movement speed and emits flame particles while active:
```mcfunction
#(in load function)
data modify storage affect:data registry."mypack:on_fire".start set value "attribute @s movement_speed modifier add mypack:effect/on_fire 0.2 add_multiplied_total"
data modify storage affect:data registry."mypack:on_fire".tick set value "particle flame ~ ~1 ~ 0.2 0.2 0.2 0.1 2"
data modify storage affect:data registry."mypack:on_fire".end set value "attribute @s movement_speed modifier remove mypack:effect/on_fire"
```

This effect can be applied like so:
```mcfunction
# gives "mypack:on_fire" to the executer of this function for 4 seconds.
data merge storage affect:in {give:{id:"mypack:on_fire", duration:80}}
function affect:api/give
```

### Create an effect with levels/potency:

Defines `mypack:heavy`, which increases knockback resistance by 10% and decreases movement speed by 10% for each `level` (specified by attached data):

Definition header:
```mcfunction
#(in load function)
data modify storage affect:data registry."mypack:heavy".start set value "function mypack:_/heavy/start"
data modify storage affect:data registry."mypack:heavy".end set value "function mypack:_/heavy/end"
```

`mypack:_/heavy/start`:
```mcfunction
# multiply the level of the effect by 0.1 and store it in 'heavy.percent'
execute store result storage mypack:var heavy.percent float 0.1 run data get storage affect:data this[-1].data.level

# run child function so 'heavy.percent' is accessible via macro
function mypack:_heavy/start.1 with storage mypack:var heavy
```

`mypack:_/heavy/start.1`:
```mcfunction
$attribute @s knockback_resistance modifier add mypack:effect/heavy $(percent) add_multiplied_base
$attribute @s movement_speed modifier add mypack:effect/heavy -$(percent) add_multiplied_base
```

`mypack:_/heavy/end`:
```mcfunction
attribute @s knockback_resistance modifier remove mypack:effect/heavy
attribute @s movement_speed modifier remove mypack:effect/heavy
```

Applying this effect:
```mcfunction
# gives "mypack:heavy" with level:3 to the executer of this function for 30 seconds.
data merge storage affect:in {give:{id:"mypack:heavy", duration:6000, data:{level:3}}}
function affect:api/give
```

### Duplicate protocol that adds/stacks duration:
The function executed by the `duplicate_protocol` component:
```mcfunction
# get and add the durations of the merging instances (provided by affect:data -> this[-1].duplicate)
execute store result score *old_duration -mypack run data get storage affect:data this[-1].duplicate.old.duration
execute store result score *new_duration -mypack run data get storage affect:data this[-1].duplicate.new.duration
scoreboard players operation *new_duration -mypack += *old_duration -mypack

# store the added duration back into affect:data -> this[-1].duplicate.new
execute store result storage affect:data this[-1].duplicate.new.duration int 1 run scoreboard players get *new_duration -mypack

# It might make more sense to not trigger the 'end' or 'start' of the effect, since it's just a "continuance".
data modify storage affect:data this[-1].duplicate.trigger set value {start:false, end:false}
```
___

<p align="center">
  <img src="https://sixslime.github.io/info/logos/temporary_documentation.svg" width="75%" alt="Temporary Documentation Tag"/>
</p>
