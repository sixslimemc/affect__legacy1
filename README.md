
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
- `duplicate_protocol`: Command that handles the logic when a c-effect is applied but is already present on the target.

In addition to having a duration, c-effect instances can have arbitrary data attached, which is accessible to all of a c-effects components.
# Usage
### Conceptual
A c-effect has one **definition** that defines it's behavior (the four components described above.)

Once a c-effect is defined, it can be applied to an entity, creating an **instance** of that c-effect. \
An instance of a c-effect has a duration, and can optionally have attached data, accessible by it's components.

An entity **cannot** have multiple instances of the same c-effect.

If a c-effect is applied to an entity that already has an instance of the same c-effect active, that c-effect's `duplicate_protocol` is executed, which handles how the two instances are merged. \
*By default (no duplicate protocol specified), the new instance always overrides the old instance.*

### Defining Effects
#### Effect Identifiers
A c-effect must have an EffectIdentifier, which effectively acts as it's name. \
An EffectIdentifier must be in a format similar to NBT storage locations: **`<namespace>:<arbitrary path>`**. \
*(ex: `mypack:some_category/my_effect`.)* \
By convention, `<namespace>` must be the namespace that the c-effect is being defined in.

#### Effect Definition
To define a c-effect, add an object under the path `registry.<EffectIdentifier>` in storage `affect:data` with the following keys:
| NBT path | Type | Description |
|--|--|--|
| `start` | string (command) | Command that runs when c-effect is applied, before the first tick of being active. |
| `tick` | string (command) | Command that runs every tick while the c-effect is active. |
| `end` | string (command) | Command that runs immediately after the c-effect wears off or is removed. |
| `duplicate_protocol` | string (command) | Command that handles the logic when a c-effect is applied but is already present on the target (See Duplicate Protocol). |

Any key may be omitted if no command is desired for the given key. \
 (ex: if `end` is omitted, the c-effect will not run any command when it wears off.)

#### Effect Implementation
 C-effect instances can be provided with arbitrary data when applied (see Giving/Removing Effects). \
`this[-1].data` in storage `affect:data` will hold this data when `start`, `tick`, and `end` commands are executed.

___

<p align="center">
  <img src="https://sixslime.github.io/info/logos/temporary_documentation.svg" width="75%" alt="Temporary Documentation Tag"/>
</p>
