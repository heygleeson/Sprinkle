# 🍩 Sprinkle

**v0.1.0 | 05-01-2022**

A wrapper for GameMaker's native particle functions.

Adds syntactic sugar by using **GML 2.3+ syntax** to implement **'method-chaining'**, allowing code to be written faster and be more legible.

[Download the latest release](https://github.com/heygleeson/Sprinkle/releases)
[Read the Wiki](https://github.com/heygleeson/Sprinkle/wiki)

## Comparison

Writing native functions to utilise GameMaker's particle system looks like this:

```gml
global.p1 = part_type_create();
part_type_shape(global.p1, pt_shape_pixel);
part_type_size(global.p1, 1, 3, 0, 0);
part_type_scale(global.p1, 1, 1);
part_type_colour1(global.p1, c_white);
part_type_alpha2(global.p1, 1, 0);
part_type_speed(global.p1, 2, 4, 0, 0);
part_type_direction(global.p1, 0, 180, 0, 0);
part_type_gravity(global.p1, 0.20, 270);
part_type_orientation(global.p1, 0, 0, 0, 0, 1);
part_type_blend(global.p1, 1);
part_type_life(global.p1, 15, 60);
```

This wrapper/library allows you to write the same code like this:

```js
global.p1 = new ParticleType()
            .shape(pt_shape_pixel)
            .size(1,3)
            .scale(1,1)
            .color(c_white)
            .alpha(1,0)
            .speed(2,4)
            .direction(0,180)
            .gravity(0.20, 270)
            .orientation(0, 0, 0, 0, 1)
            .blend(true)
            .life(15, 60);
```

## Features

This library covers all the native functions (including extensive JSDoc documentation) for:
- ParticleSystems
- ParticleEmitters
- ParticleTypes

Refer to the [Wiki](https://github.com/heygleeson/Sprinkle/wiki) to see the full list of methods.

- PhysicsParticles *are not yet supported*

## Usage

Basic setup looks like this:

**Create Event**
```js
/// Create Event
// Define ParticleTypes
partTypes = {
    fire : new ParticleType()
        .alpha(0.6, 0.0),
        .setColor(c_yellow,c _red),
        .life(50, 60),
        // (etc.)
    // (etc.)
}

// Create Particle System and Emitter
partSystem = new ParticleSystem();
partEmit = new ParticleEmitter(partSystem.id).stream(partTypes.fire.id,20);

// Example: Basic Toggle
active = true;
```

**Step Event**
```js
/// Step Event
// Example: Toggle AutoUpdate using Spacebar
if (keyboard_check_released(vk_enter)) {
    active = !active;
    partSystem.autoUpdate(active);
}
```

---

### Notes

(v0.1.0 / GMS 2.3.7.606) GameMaker has a compiler error where **in-built variables** cannot be re-declared as `static` in constructors:
- `speed`
- `direction`
- `gravity`

These methods are therefore currently 'non-static'. This does not significantly impact the performance of the library, just addressing the inconsistency here.
