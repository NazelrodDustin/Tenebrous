// Create Battle view;

if (view_current == 0){
	with (obj_overworldRoomManager){
		if (surface_exists(surfaceCorruptMix)){
			draw_clear(c_black);
			draw_surface(surfaceCorruptMix, 0, -room_height);
		}
	}
}

if (view_current == 1){
	with (obj_overworldRoomManager){
		if (surface_exists(surfaceGrassNormal)){
			draw_surface(surfaceGrassNormal, 0, 0);
		}
		
		gpu_set_blendmode(bm_subtract);
		draw_sprite_ext(sprite_index, 0, 0, 0, 1, 1, 0, c_black, 1);
		gpu_set_blendmode(bm_normal);
	}
	
	with (obj_playerOverworld){
		draw_sprite_ext(sprite_index, image_index, x + xOffset, y + yOffset, 1, 1, rotation, c_white, 1);	
	}
	
	with (obj_house){
		draw_sprite_ext(sprite_index, corrupted, x, y, 1, 1, 0, c_white, 1);	
	}
	

}

if (view_current == 2){
	with (obj_overworldRoomManager){
		if (surface_exists(surfaceGrassCorrupt)){
			draw_surface(surfaceGrassCorrupt, 0, room_height);
		}
	
		gpu_set_blendmode(bm_subtract);
		draw_sprite_ext(sprite_index, 0, 0, room_height, 1, 1, 0, c_black, 1);
		gpu_set_blendmode(bm_normal);
	}
	
	with (obj_playerOverworld){
		draw_sprite_ext(sprite_index, image_index, x + xOffset, room_height + y + yOffset, 1, 1, rotation, c_gray, 1);
	}
	
	with (obj_house){
		draw_sprite_ext(sprite_index, corrupted, x, room_height + y, 1, 1, 0, c_white, 1);
	}
	

}

if (view_current == 3){
	shader_set(shd_overworld);
	
	texture_set_stage(shader_get_sampler_index(shd_overworld, "corruptMap"), surface_get_texture(mixSurface));
	texture_set_stage(shader_get_sampler_index(shd_overworld, "corrupt"), surface_get_texture(corruptSurface));
	draw_surface(normalSurface, global.drawX, global.drawY);
	
	shader_reset();
	//draw_surface_part(corruptSurface, 0, 540 / 2, 960, 540 / 2, -960, 1620 + (540 / 2));
}

if (view_current == 4){
	draw_set_color(battleBG);
	draw_rectangle(global.drawX, global.drawY, global.drawX + 960, global.drawY + 540, false);	

	part_system_drawit(battleVoidPartSystem);
	
	
	
	var drawX = global.drawX + 480;
	var drawY = global.drawY + 206
	random_set_seed(global.seed);
	var randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, drawX, drawY, (5 + randomScaleOffset) * battleBGSpriteScale, (5 + randomScaleOffset) * battleBGSpriteScale, (0.5 + random_range(-0.25, 0.25)) * battleBGSpriteRotation, battlePortalC0, 1);
	randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, drawX, drawY, (4.5 + randomScaleOffset) * battleBGSpriteScale, (4.5 + randomScaleOffset) * battleBGSpriteScale, (1.5 + random_range(-0.5, 0.5)) * battleBGSpriteRotation, battlePortalC1, 1);
	randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, drawX, drawY, (4 + randomScaleOffset) * battleBGSpriteScale, (4 + randomScaleOffset) * battleBGSpriteScale, (3 + random_range(-1, 1)) * battleBGSpriteRotation, battlePortalC2, 1);
	randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, drawX, drawY, (3.5 + randomScaleOffset) * battleBGSpriteScale, (3.5 + randomScaleOffset) * battleBGSpriteScale, (4.5 + random_range(-1.5, 1.5)) * battleBGSpriteRotation, battlePortalC0, 1);
	randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, drawX, drawY, (3 + randomScaleOffset) * battleBGSpriteScale, (3 + randomScaleOffset) * battleBGSpriteScale, (7.5 + random_range(-2, 2)) * battleBGSpriteRotation, battlePortalC3, 1);
	randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, drawX, drawY, (2.5 + randomScaleOffset) * battleBGSpriteScale, (2.5 + randomScaleOffset) * battleBGSpriteScale, (10 + random_range(-2.5, 2.5)) * battleBGSpriteRotation, battlePortalC2, 1);
	randomScaleOffset = random_range(-0.25, 0.25);
	draw_sprite_ext(spr_battleBG, 0, drawX, drawY, (2 + randomScaleOffset) * battleBGSpriteScale, (2 + randomScaleOffset) * battleBGSpriteScale, (15 + random_range(-3, 3)) * battleBGSpriteRotation, battlePortalC0, 1);
	randomize();
	// Reset draw color
	draw_set_color(c_white);
	
	for (var i = 0; i < array_length(battlePositions[battlePosition]); i++){
		
		draw_sprite(spr_placeholder, 0, global.drawX + battlePositions[battlePosition][i][0], global.drawY + battlePositions[battlePosition][i][1]);
	}
	
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
	draw_surface_ext(battlePartSurface, global.drawX + 960 + battlePartSurfaceOffset, global.drawY + 312, 1, 1, 180 - 22.5, c_white, 1);
	draw_surface_ext(battlePartSurface, global.drawX - battlePartSurfaceOffset, global.drawY + 100, 1, 1, -22.5, c_white, 1);
	
}


if (view_current == 7){
	
	if (!surface_exists(surfaceCorruptPercent)){
		surfaceCorruptPercent = surface_create(1, 1);	
	}
	
	if (!global.pauseOverworld){
		if (surface_exists(surfaceCorruptPercent) && surface_exists(mixSurface)){
		
			surface_set_target(surfaceCorruptPercent);
			shader_set(shd_corruptionPercent);
		
			texture_set_stage(shader_get_sampler_index(shd_corruptionPercent, "corruptionMap"), surface_get_texture(mixSurface));
			draw_rectangle(0, 0, 1, 1, false);
		 
			shader_reset();	
		

			surface_reset_target();
		}
	}
}