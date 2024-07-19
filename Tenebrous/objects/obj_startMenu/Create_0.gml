/// @description Insert description here
// You can write your code in this editor

with (all){
	if (other != self){
		instance_destroy(other);
	}
}

global.lastBW = browser_width;
global.lastBH = browser_height;

surface_resize(application_surface, browser_width, browser_height);

display_set_gui_size(browser_width, browser_height);

window_set_size(browser_width, browser_height);
