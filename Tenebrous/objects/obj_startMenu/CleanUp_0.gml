/// @description Insert description here
// You can write your code in this editor

//show_debug_message("Deleting Start Menu");

if (surface_exists(menuSurface)){
	surface_free(menuSurface);
}
audio_stop_sound(snd_musicLevelClear);