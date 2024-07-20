/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_black);


if (inBattle){
	if (!surface_exists(surfBattle)){
		surfBattle = surface_create(960, 540);
	}

	surface_set_target(surfBattle);
	draw_sprite_tiled(spr_smear, floor(smearFrame), smearX, smearY);

	surface_reset_target();
	draw_surface(surfBattle, 2048, 1620);
}

if (view_current == 7){
	if (surface_exists(overworldSurface)){
		draw_surface_part(overworldSurface, 0, (surface_get_height(overworldSurface) / 2) - ((surface_get_height(overworldSurface) / 2) - (overworldSurfacePosition / 2)), 960, 540, 2048, 1620 + overworldSurfacePosition);	
	}
}