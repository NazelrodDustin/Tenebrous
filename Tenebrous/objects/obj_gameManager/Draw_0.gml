/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_black);

if (!surface_exists(surfBattle)){
	surfBattle = surface_create(960, 540);
}

surface_set_target(surfBattle);
draw_sprite_tiled(spr_smear, floor(smearFrame), smearX, smearY);

surface_reset_target();
draw_surface(surfBattle, -960, -540);