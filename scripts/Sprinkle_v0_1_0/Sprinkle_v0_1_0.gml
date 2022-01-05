/*

	🍩 Sprinkle by @heygleeson
	
	v0.1.0 | 05-01-2022
	https://https://github.com/heygleeson/sprinkle
	
	A wrapper for GameMaker's particle functions.
	Utilises GML 2.3+ syntax to utilise 'method-chaining', allowing for code to be written faster and be more legible.

*/

function ParticleSystem(_autoUpdate = true, _autoDraw = true) constructor {
	
	id = part_system_create();
	
	/// @func	exists()
	/// @desc	Returns whether this particle system exists.
	static exists = function() {
		return part_system_exists(id);
	}	

	/// @func	clear()
	/// @desc	Clears all associated emitters/particles, resets depth/position.
	static clear = function() {
		part_system_clear(id);
	}

	/// @func	destroy()
	/// @desc	Removes particle system from memory, destroying all associated emitters/particles.
	static destroy = function() {
		part_system_destroy(id);
	}

	/// @func	destroyEmitters()
	/// @desc	Removes all associated emitters from memory.
	static destroyEmitters = function() {
		part_emitter_destroy_all(id);
	}
	
	/// @func	clearParticles()
	/// @desc	Clear all associated 'alive' particles.
	static clearParticles = function() {
		part_particles_clear(id);	
	}
	
	// ---

	/// @func	createLayer(layerid)
	/// @desc	Generates a new ParticleSystem that can be made `persistent` between rooms, as well as defining a new layer to set it to.
	/// @arg	{real|string} layerid		Unique Layer ID, as defined by layer_create() or in the Room Editor.
	/// @arg	{bool} persistent			Should this ParticleSystem persist between rooms?
	static createLayer = function(_layerid,_persistent = false) {
		// TODO: Do we need to clean up this old particlesystem?
		oldid	= id;
		
		// Create new, 'persistent' particle system.
		id		= part_system_create_layer(_layerid,_persistent);
		
		// Note: User should be storing this struct in a permanant/global variable so that it does not get lost.
		
		return self;
	}
	
	/// @func	getLayer()
	/// @desc	Retrieve unique layer ID for this particle system, if manually assigned (otherwise returns 0).
	static getLayer = function() {
		return part_system_get_layer(id);
	}
	
	/// @func	setLayer(layerid)
	/// @desc	Switch the current ParticleSystem to a new layer.
	/// @arg	{layerid} layerid		Unique Layer ID, as defined by layer_create() or in the Room Editor.
	static setLayer = function(_layerid) {
		part_system_layer(id,_layerid);
		return self;
	}
	
	/// @func	setDepth(depth)
	/// @desc	Sets the draw depth of the particle system, same as 'layer depth'.
	/// @arg	{int} depth				The depth at which to set the ParticleSystem.
	static setDepth = function(_depth) {
		part_system_depth(id,_depth);
		return self;
	}
	
	/// @func	position(x, y)
	/// @desc	Updates the ParticleSytem's 'origin' position (default: 0,0)
	/// @arg	{real} x				x position
	/// @arg	{real} y				y position
	static position = function(_x,_y) {
		part_system_position(id,_x,_y);
		return self;
	}

	// ---
	
	/// @func	createParticle(x, y, type, num)
	/// @desc	Creates a particle (without using an emitter).
	/// @arg	{real} x				x position (relative to ParticleSystem x position)
	/// @arg	{real} y				y position (relative to ParticleSystem y position)
	/// @arg	{type} type				ParticleType id
	/// @arg	{int} num				number of particles to create
	static createParticle = function(_x,_y,_type,_num) {
		part_particles_create(id,_x,_y,_type,_num);
		return self;
	}
	
	/// @func	getCount()
	/// @desc	Returns the total number of `alive` particles attached to this ParticleSystem.
	static getCount = function() {
		return part_particles_count(id);	
	}
	
	/// @func	drawOrder(frontToBack)
	/// @desc	Toggle whether newer particles should be drawn in front of old ones. 
	/// @arg	{bool} frontToBack		(Default: true)
	static drawOrder = function(_front) {
		part_system_draw_order(id,_front);
		return self;
	}

	// ---
	
	/// @func	update()
	/// @desc	Updates the ParticleSystem and all associated emitters/particles. (Typically used when autoUpdate = false)
	static update = function() {
		part_system_update(id);
	}
	
	/// @func	draw()
	/// @desc	Runs the Draw Event for this ParticleSystem. (Typically used when autoDraw = false)
	static draw = function() {
		part_system_drawit(id);
	}
	
	/// @func	autoUpdate(auto)
	/// @desc	Enables/Disables automatic updating of this ParticleSystem.
	/// @arg	{bool} auto				Should this ParticleSystem update automatically?
	static autoUpdate = function(_auto) {
		part_system_automatic_update(id,_auto);
	}
	
	/// @func	autoDraw(auto)
	/// @desc	Enables/Disables automatic drawing of this ParticleSystem.
	/// @arg	{bool} auto				Should this ParticleSystem draw automatically?
	static autoDraw = function(_auto) {
		part_system_automatic_draw(id,_auto);
	}
	
	autoUpdate(_autoUpdate);
	autoDraw(_autoDraw);
	
}

function ParticleEmitter(_partSystem = new ParticleSystem().id) constructor {

	ps = _partSystem;
	id = part_emitter_create(ps);
	
	/// @func	exists()
	/// @desc	Returns if emitter currently exists.
	static exists = function() {
		return part_emitter_exists(ps,id);
	}
	
	/// @func	clear()
	/// @desc	Resets emitter to its default state (removing streams/regions)
	static clear = function() {
		part_emitter_clear(ps,id);
	}

	/// @func	destroy()
	/// @desc	Destroys current emitter, and all associated particles.
	static destroy = function() {
		part_emitter_destroy(ps,id);
	}
	
	/// @func	burst(type, num)
	/// @desc	Create a one-off 'burst' of particles on this emitter.
	/// @arg	{int} type				ParticleType id
	/// @arg	{int} num				number of particles to burst
	static burst = function(_type,_num) {
		part_emitter_burst(ps,id,_type,_num);
		return self;
	}

	/// @func	region(x1, y1, x2, y2, shape, distribution)
	/// @desc	Set the region/shape/distribution of the current emitter.
	/// @arg	{real} x1				left position
	/// @arg	{real} y1				top position
	/// @arg	{real} x2				right position
	/// @arg	{real} y2				bottom position
	/// @arg	{const} [shape]			ps_shape_(rectangle/ellipse/diamond/line)
	/// @arg	{const} [distr]			ps_distr_(linear,gaussian,invgaussian)
	static region = function(_x1,_y1,_x2,_y2,_shape = ps_shape_rectangle,_distr = ps_distr_linear) {
		part_emitter_region(ps,id,_x1,_x2,_y1,_y2,_shape,_distr);
		return self;
	}

	/// @func	position(x, y)
	/// @desc	Set the emitter region to be a singular point.
	/// @arg	{real} x				x position
	/// @arg	{real} y				y position
	static position = function(_x,_y) {
		part_emitter_region(ps,id,_x,_x,_y,_y,ps_shape_rectangle,ps_distr_linear);
		return self;
	}
	/// @func	stream(type, num)
	/// @desc	Set up a 'stream' where particles are created every step on this emitter.
	/// @arg	{int} type				ParticleType id
	/// @arg	{int} num				number of particles to stream per step
	static stream = function(_type,_num) {
		part_emitter_stream(ps,id,_type,_num);
		return self;
	}
	
}

function ParticleType() constructor {

	id = part_type_create();
	
	/// @func	exists()
	/// @desc	Returns whether this ParticleType exists.
	static exists = function() {
		return part_type_exists(id);
	}
	
	/// @func	clear()
	/// @desc	Reset ParticleType properties to their 'default' values.
	static clear = function() {
		part_type_clear(id);
		return self;
	}

	/// @func	destroy()
	/// @desc	Removes ParticleType from memory.
	static destroy = function() {
		part_type_destroy(id);	
	}
	
	// ---
	
	/// @func	alpha(alpha1, alpha2, alpha3)
	/// @desc	Set up to 3 alpha values for the ParticleType to blend through its lifetime.
	/// @arg	{real} alpha1			first alpha value
	/// @arg	{real} [alpha2]			second alpha value (middle/end)
	/// @arg	{real} [alpha3]			third alpha value (end)
	static alpha = function() {
		switch(argument_count) {
			case 1: part_type_alpha1(id,argument[0]); break;
			case 2: part_type_alpha2(id,argument[0],argument[1]); break;
			case 3: part_type_alpha3(id,argument[0],argument[1],argument[2]); break;
		}
		return self;
	}	

	/// @func	blend(additive)
	/// @desc	Toggle additive blendmode when drawing this ParticleType.
	/// @arg	{bool} additive			whether to use additive blend mode (default: false)
	static blend = function(_additive) {
		part_type_blend(id,_additive);
		return self;
	}
	
	/// @func	color(color1, [color2], [color3])
	/// @desc	Set up to 3 color values for the ParticleType to blend through its lifetime.
	/// @arg	color1					first color value
	/// @arg	[color2]				second color value (middle/end)
	/// @arg	[color3]				third color value (end)
	static color = function() {
		switch(argument_count) {
			case 1: part_type_color1(id,argument[0]); break;
			case 2: part_type_color2(id,argument[0],argument[1]); break;
			case 3: part_type_color3(id,argument[0],argument[1],argument[2]); break;
		}
		return self;
	}

	/// @func	colour(colour1, [colour2], [colour3])
	/// @desc	Set up to 3 colour values for the ParticleType to blend through its lifetime.
	/// @arg	colour1					first colour value
	/// @arg	[colour2]				second colour value (middle/end)
	/// @arg	[colour3]				third colour value (end)
	static colour = function() {
		switch(argument_count) {
			case 1: part_type_colour1(id,argument[0]); break;
			case 2: part_type_colour2(id,argument[0],argument[1]); break;
			case 3: part_type_colour3(id,argument[0],argument[1],argument[2]); break;
		}
		return self;
	}	

	/// @func	setDirection(min, max, increase, wiggle)
	/// @desc	Set the movement direction of the ParticleType.
	/// @arg	{real} angleMin			minimum initial angle (0-360)
	/// @arg	{real} angleMax			maximum initial angle (0-360)
	/// @arg	{real} [angleIncrease]	angle increase per step
	/// @arg	{real} [angleWiggle]	random angle offset per step
	direction = function(_min,_max,_inc = 0,_wiggle = 0) {
		part_type_direction(id,_min,_max,_inc,_wiggle);
		return self;
	}

	/// @func	setGravity(amount, direction)
	/// @desc	Set the gravity strength/direction that affects the ParticleType during its lifetime.
	/// @arg	{real} amount			gravity strength
	/// @arg	{real} direction		gravity direction
	gravity = function(_amount,_dir) {
		part_type_gravity(id,_amount,_dir);
		return self;
	}

	/// @func	life(min, max)
	/// @desc	Set the minimum/maximum lifespan of new instances of this ParticleType.
	/// @arg	{real} min				minimum lifespan
	/// @arg	{real} max				maximum lifespan
	static life = function(_min,_max) {
		part_type_life(id,_min,_max);
		return self;
	}

	/// @func	orientation(min, max, increase, wiggle)
	/// @desc	Set 'image_angle' properties of the associated sprite of this ParticleType.
	/// @arg	{real} angleMin			minimum initial angle (0-360)
	/// @arg	{real} angleMax			maximum initial angle (0-360)
	/// @arg	{real} angleIncrease	angle increase per step
	/// @arg	{real} angleWiggle		random angle offset per step
	static orientation = function(_min,_max,_inc,_wiggle = 0,_relative = 0) {
		part_type_orientation(id,_min,_max,_inc,_wiggle,_relative);
		return self;
	}
	
	/// @func	scale(xscale, yscale)
	/// @desc	Set initial values for both 'image_xscale'/'image_yscale' of the associated sprite of this ParticleType.
	/// @arg	{real} xscale			image_xscale of the sprite (default: 1.0)
	/// @arg	{real} yscale			image_yscale of the sprite (default: 1.0)
	static scale = function(_xscale,_yscale) {
		part_type_scale(id,_xscale,_yscale);
		return self;
	}
	
	/// @func	shape(shape)
	/// @desc	Use an in-built particle sprite on this ParticleType.
	/// @arg	{constant} shape		Accepts: pt_shape_(pixel/disk/square/line/star/circle/ring/sphere/flare/spark/explosion/cloud/smoke/snow)
	static shape = function(_shape) {
		part_type_shape(id,_shape)
		return self;
	}
	
	/// @func	size(min, max, inc, wiggle)
	/// @desc	Set `size` properties of the associated sprite of this ParticleType.
	/// @arg	{real} sizeMin			minimum initial size
	/// @arg	{real} sizeMax			maximum initial size
	/// @arg	{real} [sizeIncrease]	size increase per step
	/// @arg	{real} [sizeWiggle]		random size offset per step
	static size = function(_min,_max,_inc = 0,_wiggle = 0) {
		part_type_size(id,_min,_max,_inc,_wiggle);
		return self;
	}

	/// @func	speed(min, max, inc, wiggle)
	/// @desc	Set the movement speed of the ParticleType.
	/// @arg	{real} speedMin			minimum speed
	/// @arg	{real} speedMax			maximum speed
	/// @arg	{real} speedIncrease	speed increase per step
	/// @arg	{real} speedWiggle		random speed offset per step
	speed = function(_min,_max,_inc = 0,_wiggle = 0) {
		part_type_speed(id,_min,_max,_inc,_wiggle);
		return self;
	}

	/// @func	sprite(sprite, anim, stretch, random)
	/// @desc	Set up a custom sprite to use on this ParticleType.
	/// @arg	{sprite} sprite			sprite_index to use
	/// @arg	{bool} anim				whether to use the sprite's animation
	/// @arg	{bool} stretch			whether to stretch sprite animation to match lifespan
	/// @arg	{bool} random			whether to use a random sub-image
	static sprite = function(_sprite,_anim,_stretch,_random) {
		part_type_sprite(id,_sprite,_anim,_stretch,_random);
		return self;
	}
	
	// ---
	
	/// @func	step(num, type)
	/// @desc	Set this ParticleType to stream another ParticleType on itself during its lifetime.
	/// @arg	{int} type				ParticleType id to stream
	/// @arg	{int} num				number of particles to stream per step
	static step = function(_type,_num) {
		if (_type != id) {
			part_type_step(id,_num,_type);
		}
		return self;
	}

	/// @func	death(num, type)
	/// @desc	Set this ParticleType to 'burst' another ParticleType on itself at the end of its lifetime.
	/// @arg	{int} type				ParticleType id
	/// @arg	{int} num				number of particles to burst
	static death = function(_type, _num) {
		if (_type != id) {
			part_type_death(id,_num,_type);
		}
		return self;
	}
}
	