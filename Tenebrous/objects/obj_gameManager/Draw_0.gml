/// @description Insert description here
// You can write your code in this editor

// Create Battle view;
if (view_current == 4){
	draw_set_color(battleBG);
	draw_rectangle(2048, -64, 2048 + 960, 540, false);	
	
	random_set_seed(global.seed);
	var randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, 2048 + 480, 206, (5 + randomScaleOffset) * battleBGSpriteScale, (5 + randomScaleOffset) * battleBGSpriteScale, (0.5 + random_range(-0.25, 0.25)) * battleBGSpriteRotation, battleBG, 1);
	randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, 2048 + 480, 206, (4.5 + randomScaleOffset) * battleBGSpriteScale, (4.5 + randomScaleOffset) * battleBGSpriteScale, (1.5 + random_range(-0.5, 0.5)) * battleBGSpriteRotation, c_maroon, 1);
	randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, 2048 + 480, 206, (4 + randomScaleOffset) * battleBGSpriteScale, (4 + randomScaleOffset) * battleBGSpriteScale, (3 + random_range(-1, 1)) * battleBGSpriteRotation, c_dkgray, 1);
	randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, 2048 + 480, 206, (3.5 + randomScaleOffset) * battleBGSpriteScale, (3.5 + randomScaleOffset) * battleBGSpriteScale, (4.5 + random_range(-1.5, 1.5)) * battleBGSpriteRotation, battleBG, 1);
	randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, 2048 + 480, 206, (3 + randomScaleOffset) * battleBGSpriteScale, (3 + randomScaleOffset) * battleBGSpriteScale, (7.5 + random_range(-2, 2)) * battleBGSpriteRotation, c_gray, 1);
	randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, 2048 + 480, 206, (2.5 + randomScaleOffset) * battleBGSpriteScale, (2.5 + randomScaleOffset) * battleBGSpriteScale, (10 + random_range(-2.5, 2.5)) * battleBGSpriteRotation, c_dkgray, 1);
	randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, 2048 + 480, 206, (2 + randomScaleOffset) * battleBGSpriteScale, (2 + randomScaleOffset) * battleBGSpriteScale, (15 + random_range(-3, 3)) * battleBGSpriteRotation, battleBG, 1);
	randomize();
	// Reset draw color
	draw_set_color(c_white);
	
	// If surface does't exist, create it.
	if (!surface_exists(battlePartSurface)){
		battlePartSurface = surface_create(1024, 256);
	}
	
	// Draw particle system to surface
	surface_set_target(battlePartSurface);
	draw_clear_alpha(c_black, 0);
	part_system_drawit(battlePartSystem);
	surface_reset_target();
	
	// Draw the speed lines.
	draw_surface_ext(battlePartSurface, 2048 + 960 + battlePartSurfaceOffset, 312, 1, 1, 180-22.5, c_white, 1);
	draw_surface_ext(battlePartSurface, 2048 - battlePartSurfaceOffset, 100, 1, 1, -22.5, c_white, 1);
	
}