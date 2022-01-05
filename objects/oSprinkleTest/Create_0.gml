/// @desc Setup

// Define Particle Types
particleTypes = {
	sprinkle	: new ParticleType()
				.alpha(0.5, 0.4, 0.1)
				.blend(true)
				.colour(c_fuchsia, c_aqua, c_purple)
				.shape(pt_shape_line)
				.life(90, 120)
				.speed(.6, .9, -0.01, 0.1)
				.size(.2, .3, -0.001)
				.direction(0, 360)
				.orientation(0, 360, 5),
	smoke	: new ParticleType()
				.alpha(0.0, 0.5, 0.0)
				.shape(pt_shape_cloud)
				.colour(c_dkgray, c_black)
				.life(10, 20)
				.speed(0.4, 0.6, 0.01, 0)
				.size(0.2, 0.30, -0.01, 0)
				.direction(80, 100)
				.gravity(0.1, 90),
}

// Stream 'smoke' on every 'sprinkle' particle.
particleTypes.sprinkle.death(particleTypes.smoke.id,3);

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