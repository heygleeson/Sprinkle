# GM-Particle

**v0.1.0 | 05-01-2022**

A wrapper for GameMaker's particle functions.
Utilises GML 2.3+ syntax to utilise 'method-chaining', allowing for code to be written faster and be more legible.

---

## Comparison

Writing native code to utilise GameMaker's particle system looks like this:

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

```gml
global.p1 = new ParticleType()
			.shape(pt_shape_pixel)
			.size(1,3)
			.scale(1,1)
			.setColor(c_white)
			.alpha(1,0)
			.setSpeed(2,4)
			.setDirection(0,180)
			.setGravity(0.20, 270)
			.orientation(0, 0, 0, 0, 1)
			.blend(true)
			.life(15, 60);

```

## Features

This library covers:
- **ParticleSystem()**s
- **ParticleEmitter()**s
- **ParticleType()**s

**PhysicsParticles** are currently *not yet supported*.

## Usage

Basic setup looks like this:

```gml
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

/// Step Event

	

```

Each constructor (e.g. `ParticleSystem()`) contains a single variable, `id`, which stores the relevant index that is used by GameMaker's particle functions, as well as static methods that cover all of the native functions that are used for particles.

## Notes

(v0.1.0/GMS 2.3.7.606) GML has a few **in-built variables** that currently cannot be redeclared as `static` in constructors:
- `speed`
- `direction`
- `gravity`
These methods are therefore currently 'non-static'. This does not significantly impact the performance of the library, just addressing the inconsistency here.


- Refer to the [Wiki](...) to see the full list.