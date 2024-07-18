/// @description Insert description here
// You can write your code in this editor

with (all){
	if (other != self){
		instance_destroy(other);
	}
}

surface_resize(application_surface, 960, 540);

display_set_gui_size(960, 540);

window_set_size(960, 540);
