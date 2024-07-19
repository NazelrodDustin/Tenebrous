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

if (view_current == 7 && surface_exists(overworldSurface)){
	draw_surface_part(overworldSurface, 0, (surface_get_height(overworldSurface) / 2) - ((surface_get_height(overworldSurface) / 2) - (overworldSurfacePosition / 2)), 960, 540, -960, -surface_get_height(overworldSurface) + overworldSurfacePosition);	
}