/// @description Insert description here
// You can write your code in this editor


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