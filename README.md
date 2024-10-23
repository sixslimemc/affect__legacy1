
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
### Defining Effects
#### Effect Identifiers
A c-effect must have an EffectIdentifier, which effectively acts as it's name. \
An EffectIdentifier must be in a format similar to NBT storage locations: **`<namespace>:<arbitrary path>`**. \
*(ex: `mypack:some_category/my_effect`.)* \
By convention, `<namespace>` must be the namespace that the c-effect is being defined in.

#### Effect Definition
To define a c-effect, 
___

<p align="center">
  <img src="https://sixslime.github.io/info/logos/temporary_documentation.svg" width="75%" alt="Temporary Documentation Tag"/>
</p>
