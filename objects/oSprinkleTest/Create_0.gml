/// @desc Setup

// Define Particle Types
particleTypes = {
	dust		: new ParticleType()
				.color(c_gray)
				.life(20,20)
				.alpha(0.2,0.0)
				.shape(pt_shape_smoke)
				.size(.1,.3,-0.01,.1)
				.speed(.6, .9, -0.01, 0.1)
				.direction(0, 360)
				.orientation(0, 360, 5),
				
	sprinkle	: new ParticleType()
				.alpha(0.5, 0.4, 0.1)
				.blend(true)
				.colour(c_fuchsia, c_aqua, c_purple)
				.shape(pt_shape_line)
				.speed(.6, .9, -0.01, 0.1)
				.size(.2, .3, -0.001)
				.direction(0, 360)
				.orientation(0, 360, 5),
}

// Using ParticleType functions that depend on other ParticleTypes to already be generated.
with (particleTypes) {
	sprinkle.death(dust.id,1);	
}

// Create Particle System
partSystem = new ParticleSystem(true,true).position(room_width * .5, room_height * .5);

// Create Emitter (remember to use `.id`)
emitter = new ParticleEmitter(partSystem.id).region(-64,-64,+64,+64,ps_shape_ellipse);

// Create Stream (remember to use `.id`)
emitter.stream(particleTypes.sprinkle.id,5);

// ------------------------------------------- //

// Debug Toggle
show_debug_overlay(true);
active = true;

// Mouse
posX	= room_width * .5;
posY	= room_height * .5;
prevX	= mouse_x;
prevY	= mouse_y;