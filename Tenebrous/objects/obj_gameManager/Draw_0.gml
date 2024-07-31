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
	
	for (var i = 0; i < array_length(drawArray); i++){
		with (drawArray[i][0]){
			switch (object_get_name(object_index)){
				case "obj_playerOverworld":
					draw_sprite_ext(sprite_index, image_index, x + xOffset, y + yOffset, 1, 1, rotation, c_white, 1);
					break;
					
				case "obj_house":
					draw_sprite_ext(sprite_index, corrupted, x, y, 1, 1, 0, c_white, 1);
					break;
					
				case "obj_well":
					draw_sprite_ext(sprite_index, corrupted, x, y, 1, 1, 0, c_white, 1);
					break;
					
				case "obj_enemyPortal":
					//draw_line(x, y, targetPosition[0], targetPosition[1]);
					draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, 1);
					break;
			}
		}
	}
	
	with (obj_corruptibleParent){
		if (corrupted){
			if (object_get_name(object_index) == "obj_house"){
				var dirDiff = point_direction(global.playerOverworld.x, global.playerOverworld.y, x, y - 160);
				draw_sprite_ext(spr_directionIndicator, 0, global.playerOverworld.x + lengthdir_x(128, dirDiff), global.playerOverworld.y + lengthdir_y(128, dirDiff), 1, 1, dirDiff - 90, c_white, 1 - ((256 - (point_distance(global.playerOverworld.x, global.playerOverworld.y, x, y - 160) - 64)) / 256));
			}else{
				var dirDiff = point_direction(global.playerOverworld.x, global.playerOverworld.y, x, y);
				draw_sprite_ext(spr_directionIndicator, 0, global.playerOverworld.x + lengthdir_x(128, dirDiff), global.playerOverworld.y + lengthdir_y(128, dirDiff), 1, 1, dirDiff - 90, c_white, 1 - ((256 - (point_distance(global.playerOverworld.x, global.playerOverworld.y, x, y) - 64)) / 256));
			}
		}
	}
	
	if (!global.inBattle){
		with (global.playerOverworld){
			if (ds_list_size(interactList) > 0){
				with (interactList[| 0]){
					draw_sprite_ext(spr_controls, 2, x, y, 1, 1, 0, c_white, 1);
				}
			}
		}
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
	
	for (var i = 0; i < array_length(drawArray); i++){
		with (drawArray[i][0]){
		
			switch (object_get_name(object_index)){
				case "obj_playerOverworld":
					draw_sprite_ext(sprite_index, image_index, x + xOffset, room_height + y + yOffset, 1, 1, rotation, c_white, 1);
					break;
					
				case "obj_house":
					draw_sprite_ext(sprite_index, corrupted, x, room_height + y, 1, 1, 0, c_white, 1);
					break;
					
				case "obj_well":
					draw_sprite_ext(sprite_index, corrupted, x, room_height + y, 1, 1, 0, c_white, 1);
					break;
					
				case "obj_enemyPortal":
					//draw_line(x, room_height + y, targetPosition[0], room_height + targetPosition[1]);
					draw_sprite_ext(sprite_index, image_index, x, room_height + y, 1, 1, 0, c_white, 1);
					break;
			}
		}
	}
	
	with (obj_corruptibleParent){
		if (corrupted){
			if (object_get_name(object_index) == "obj_house"){
				var dirDiff = point_direction(global.playerOverworld.x, global.playerOverworld.y, x, y - 160);
				draw_sprite_ext(spr_directionIndicator, 0, global.playerOverworld.x + lengthdir_x(128, dirDiff), room_height + global.playerOverworld.y + lengthdir_y(128, dirDiff), 1, 1, dirDiff - 90, c_white, 1 - ((256 - (point_distance(global.playerOverworld.x, global.playerOverworld.y, x, y - 160) - 64)) / 256));
			}else{
				var dirDiff = point_direction(global.playerOverworld.x, global.playerOverworld.y, x, y);
				draw_sprite_ext(spr_directionIndicator, 0, global.playerOverworld.x + lengthdir_x(128, dirDiff), room_height + global.playerOverworld.y + lengthdir_y(128, dirDiff), 1, 1, dirDiff - 90, c_white, 1 - ((256 - (point_distance(global.playerOverworld.x, global.playerOverworld.y, x, y) - 64)) / 256));
			}
		}
	}
	
	if (!global.inBattle){
		with (global.playerOverworld){
			if (ds_list_size(interactList) > 0){
				with (interactList[| 0]){
					draw_sprite_ext(spr_controls, 2, x, y + room_height, 1, 1, 0, c_white, 1);
				}
			}
		}
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
	draw_sprite_ext(spr_battleBG, 0, drawX, drawY, (2 + randomScaleOffset) * battleBGSpriteScale, (2 + randomScaleOffset) * battleBGSpriteScale, (15 + random_range(-3, 3)) * battleBGSpriteRotation, battlePortalC1, 1);
	randomize();
	// Reset draw color
	draw_set_color(c_white);
	
	with (obj_enemy){
		if (initiative == global.selectedEnemy){
			draw_sprite_ext(spr_indicator, 0, global.drawX + 480 + x, global.drawY + 260 + y - 70, 1, 1, 0, c_white, 1);
		}
		
		draw_healthbar(global.drawX + 480 + x - 25, global.drawY + 260 + y + 10, global.drawX + 480 + x + 25, global.drawY + 260 + y + 15, (hp / maxHP) * 100, c_black, make_color_rgb(165, 48, 48), make_color_rgb(165, 48, 48), 0, true, true);
		
		draw_sprite_ext(sprite_index, 0, global.drawX + 480 + x, global.drawY + 260 + y, image_xscale * scale, scale, 0, c_white, 1);
	}
	
	draw_sprite_ext(spr_circleFade, 0, global.spellPosition[0], global.spellPosition[1], 1, 1, 0, c_white, global.spellAlpha);
	
	
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