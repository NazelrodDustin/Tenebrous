/// @description Insert description here
// You can write your code in this editor
global.deltaTime = delta_time / 1000000;


smearX += 20;
smearY += 15;

smearX = smearX % sprite_get_width(spr_smear);

smearY = smearY % sprite_get_height(spr_smear);

smearFrame += smearSpeed * global.deltaTime;
smearFrame = smearFrame % sprite_get_number(spr_smear);

var gameWidth = max(960, browser_width);
var gameHeight = max(540, browser_height);

display_set_gui_size(gameWidth, gameHeight);

window_set_size(browser_width, browser_height);

view_wport[7] = gameWidth;
view_hport[7] = gameHeight;

show_debug_message(string("view width {0}, height {1}", view_wport, view_hport));