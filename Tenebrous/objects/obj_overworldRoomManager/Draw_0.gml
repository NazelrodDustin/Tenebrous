/// @description Insert description here
// You can write your code in this editor


if (!surface_exists(surfaceGrassNormal)){
	surfaceGrassNormal = surface_create(room_width, room_height);
	
	surface_set_target(surfaceGrassNormal);
	draw_clear_alpha(c_black, 0);
	for (var i = 0; i < array_length(worldTiles); i++){
		for (var j = 0; j < array_length(worldTiles[i]); j++){
			show_debug_message(worldTiles[i][j]);
			var thisTile = worldTiles[i][j];
			show_debug_message(thisTile);
			draw_sprite_general(spr_grass, 
								0, 
								32 * thisTile[0],
								32 * thisTile[1],
								32,
								32,
								32 * i + (thisTile[3] ? 32 : 0) + (thisTile[2] == 1 || thisTile[2] == 2 ?  32 : 0),
								32 * j + (thisTile[4] ? 32 : 0) + (thisTile[2] == 2 || thisTile[2] == 3 ?  32 : 0),
								(thisTile[3] ? -1 : 1),
								(thisTile[4] ? -1 : 1),
								90 * thisTile[2],
								c_white,
								c_white,
								c_white,
								c_white,
								1);
		}
	}
	
	surface_reset_target();
}

if (!surface_exists(surfaceGrassCorrupt)){
	surfaceGrassCorrupt = surface_create(room_width, room_height);
	
	surface_set_target(surfaceGrassCorrupt);
	draw_clear_alpha(c_black, 0);
	for (var i = 0; i < array_length(worldTiles); i++){
		for (var j = 0; j < array_length(worldTiles[i]); j++){
			draw_sprite_general(spr_grassCorrupted, 
								0, 
								32 * worldTiles[i][j][0],
								32 * worldTiles[i][j][1],
								32,
								32,
								32 * i,
								32 * j,
								32 * worldTiles[i][j][3] ? -1 : 1,
								32 * worldTiles[i][j][4] ? -1 : 1,
								90 * worldTiles[i][j][2],
								c_white,
								c_white,
								c_white,
								c_white,
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