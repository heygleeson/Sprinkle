/// @desc ???


// Follow Mouse

if (mouse_check_button(mb_left)) {
	// Move the emitter region
	emitter.region(mouse_x-posX-32, mouse_y-posY-32, mouse_x-posX+32, mouse_y-posY+32);
}

if (keyboard_check_pressed(vk_shift)) {
	prevX = mouse_x;
	prevY = mouse_y;
}
if (keyboard_check(vk_shift)) {
	
	posX += mouse_x - prevX;
	posY += mouse_y - prevY;
	prevX = mouse_x;
	prevY = mouse_y;
	
	// Move the entire Particle System
	partSystem.position(posX,posY);	
}

// Toggle AutoUpdate
if (keyboard_check_released(vk_enter)) {
	active = !active;
	partSystem.autoUpdate(active);
}

// Change ParticleType Property
if (keyboard_check_pressed(ord("A"))) {
	particleTypes.fire.orientation(0, 360, -15, 1);	
}

if (keyboard_check_released(ord("A"))) {
	particleTypes.fire.orientation(0, 360, 15, 1);	
}