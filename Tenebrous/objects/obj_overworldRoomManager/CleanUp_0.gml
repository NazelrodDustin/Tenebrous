/// @description Insert description here
// You can write your code in this editor

//show_debug_message("Deleting Overworld Room Manager");


if (sprite_exists(sprite_index)){
	sprite_flush(sprite_index);	
}

if (surface_exists(surfaceCorruptMix)){
	surface_free(surfaceCorruptMix);
	surfaceCorruptMix = noone;
}

if (surface_exists(surfaceGrassNormal)){
	surface_free(surfaceGrassNormal);
	surfaceGrassNormal = noone;
}

if (surface_exists(surfaceGrassCorrupt)){
	surface_free(surfaceGrassCorrupt);
	surfaceGrassCorrupt = noone;
}