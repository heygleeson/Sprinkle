/// @desc Setup

// Define Particle Types
particleTypes = {
	fire	: new ParticleType()
				.alpha(0.5, 0.4, 0)
				.colour(c_yellow, c_orange, c_red)
				.life(300, 600)
				.speed(.4, .7, -0.01, 0.1)
				.size(8, 10, -0.01, 0.1)
				.direction(0, 360)
				.orientation(0, 360, 5, 1),
	smoke	: new ParticleType()
				.alpha(0.5, 0.0)
				.colour(c_gray, c_black)
				.life(30, 60)
				.speed(0.4, 0.6, 0.01, 0)
				.size(50, 0.60, -0.01, 0)
				.direction(80, 100)
				.gravity(0.1, 90),
}

// Create Particle System
partSystem = new ParticleSystem(true,true);//.position(room_width * .5, room_height * .5);

// Create Emitter (remember to use `.id`)
emitter = new ParticleEmitter(partSystem.id).region(-32,-32,+32,+32);

// Create Stream (remember to use `.id`)
emitter.stream(particleTypes.fire.id,20);

// ------------------------------------------- //

// Debug Toggle
show_debug_overlay(true);
active = true;

// Mouse
posX	= 0;
posY	= 0;
prevX	= mouse_x;
prevY	= mouse_y;