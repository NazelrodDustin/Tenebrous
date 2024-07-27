/// @description Insert description here
// You can write your code in this editor

draw_point(-10000, -10000);

if (!sprite_exists(sprite_index)){
	var spriteSurface = surface_create(room_width, room_height);
	
	surface_set_target(spriteSurface);
	
	random_set_seed(seed);
	
	gpu_set_blendmode(bm_add);
	//gpu_set_blendmode(bm_min);
	//gpu_set_blendmode_ext(bm_src_alpha, bm_inv_dest_alpha)
	
	for (var i = 0; i < room_height; i += 16){
		draw_sprite(spr_circleFade, 0, i, irandom_range(-4, 8));	
		draw_sprite(spr_circleFade, 0, i, room_height - irandom_range(-4, 8));	
		draw_sprite(spr_circleFade, 0, irandom_range(-4, 8), i);	
		draw_sprite(spr_circleFade, 0, room_width - irandom_range(-4, 8), i);
	}
	
	gpu_set_blendmode(bm_normal);
	
	surface_reset_target();
	
	sprite_index = sprite_create_from_surface(spriteSurface, 0, 0, room_width, room_height, false, true, 0, 0);
	sprite_collision_mask(sprite_index, false, bboxmode_automatic, 0, 0, room_width, room_height, bboxkind_precise, 0)
	image_xscale = room_width / sprite_width;
	image_yscale = room_height / sprite_height;
	image_alpha = 1;
}

if (!surface_exists(surfaceCorruptMix)){
	surfaceCorruptMix = surface_create(room_width, room_height);
}

if (surface_exists(surfaceCorruptMix)){
	surface_set_target(surfaceCorruptMix); 
	
	draw_clear(c_black);
	with (all){
		
		
		
		if (variable_instance_exists(self, "corruptionPartSystem")){
			draw_set_color(c_white);
			part_system_drawit(corruptionPartSystem);	
		}
	}
		
	surface_reset_target();
}
	


if (!surface_exists(surfaceGrassNormal)){
	surfaceGrassNormal = surface_create(room_width, room_height);
	
	surface_set_target(surfaceGrassNormal);
	draw_clear(global.grassRegularBaseColor);
	for (var i = 0; i < array_length(worldTiles); i++){
		for (var j = 0; j < array_length(worldTiles[i]); j++){
			var thisTile = worldTiles[i][j];
			draw_sprite_ext(spr_grassSplash,
							thisTile[0], 
							(i * 64) + thisTile[1], 
							(j * 64) + thisTile[2], 
							thisTile[4] ? 1 : -1, 
							thisTile[5] ? 1 : -1, 
							thisTile[3],
							global.grassRegularSplashColor,
							1);
							
		}					
	}
	
	surface_reset_target();
}

if (!surface_exists(surfaceGrassCorrupt)){
	surfaceGrassCorrupt = surface_create(room_width, room_height);
	
	surface_set_target(surfaceGrassCorrupt);
	draw_clear(global.grassCorruptedBaseColor);
	for (var i = 0; i < array_length(worldTiles); i++){
		for (var j = 0; j < array_length(worldTiles[i]); j++){
			var thisTile = worldTiles[i][j];
			draw_sprite_ext(spr_grassSplash,
							thisTile[0], 
							(i * 64) + thisTile[1], 
							(j * 64) + thisTile[2], 
							thisTile[4] ? 1 : -1, 
							thisTile[5] ? 1 : -1, 
							thisTile[3],
							global.grassCorruptedSplashColor,
							1);
							
		}					
	}
	
	surface_reset_target();
}