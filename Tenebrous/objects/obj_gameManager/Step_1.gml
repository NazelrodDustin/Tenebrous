/// @description Insert description here
// You can write your code in this editor
global.deltaTime = 1 / 60;// delta_time / 1000000;

if (inBattle){
	smearX += 20;
	smearY += 15;

	smearX = smearX % sprite_get_width(spr_smear);

	smearY = smearY % sprite_get_height(spr_smear);

	smearFrame += smearSpeed * global.deltaTime;
	smearFrame = smearFrame % sprite_get_number(spr_smear);
}

if (global.lastBW != browser_width || global.lastBH != browser_height){
	display_set_gui_size(browser_width, browser_height);

	window_set_size(browser_width, browser_height);

	view_wport[7] = browser_width;
	view_hport[7] = browser_height;
}
