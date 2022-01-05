/// @desc ???

// Destroy Emitter
emitter.destroy();

// OR, just call it from the ParticleSystem
partSystem.destroyEmitters();

// Free ParticleTypes from memory (not necessary)
var array = variable_struct_get_names(particleTypes);
var count = variable_struct_names_count(particleTypes);
for (var i = 0; i < count; i++) {
	var type = particleTypes[$ array[i]];
	type.destroy();
	variable_struct_remove(particleTypes,array[i]);
}