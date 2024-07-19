/// @description Insert description here
// You can write your code in this editor


if (global.lastBW != browser_width || global.lastBH != browser_height){
	display_set_gui_size(browser_width, browser_height);

	window_set_size(browser_width, browser_height);

	view_wport[7] = browser_width;
	view_hport[7] = browser_height;
}