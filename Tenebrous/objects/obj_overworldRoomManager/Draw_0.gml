/// @description Insert description here
// You can write your code in this editor


if (!surface_exists(surfaceGrassNormal)){
	surfaceGrassNormal = surface_create(room_width, room_height);
	
	surface_set_target(surfaceGrassNormal);
	draw_clear(global.grassRegularBaseColor);
	for (var i = 0; i < array_length(worldTiles); i++){
		for (var j = 0; j < array_length(worldTiles[i]); j++){
			show_debug_message(worldTiles[i][j]);
			var thisTile = worldTiles[i][j];
			show_debug_message(thisTile);
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
			show_debug_message(worldTiles[i][j]);
			var thisTile = worldTiles[i][j];
			show_debug_message(thisTile);
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

if (view_current == 0){
	draw_surface(surfaceGrassNormal, 0, 0);
}

if (view_current == 1){
	draw_surface(surfaceGrassCorrupt, 0, room_height);
}