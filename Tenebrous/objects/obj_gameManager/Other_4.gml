// Reset all cameras to be in proper area.

// view 0: Normal Overworld Camera.
camera_set_view_pos(view_camera[0], -960, 0);
camera_set_view_size(view_camera[0], 960, 540);

// view 1: Corrupt Overworld Camera.
camera_set_view_pos(view_camera[1], -960, 540);
camera_set_view_size(view_camera[1], 960, 540);

// view 2: Corruption Map.
camera_set_view_pos(view_camera[2], -960, 1080);
camera_set_view_size(view_camera[2], 960, 540);

// view 3: Composite View.
camera_set_view_pos(view_camera[3], -960, 1620);
camera_set_view_size(view_camera[3], 960, 540);

// view 4: Battle Camera.
camera_set_view_pos(view_camera[4], -960, 2160);
camera_set_view_size(view_camera[4], 960, 540);

camera_set_view_pos(view_camera[5], -960, 2700);
camera_set_view_size(view_camera[5], 960, 540);

camera_set_view_pos(view_camera[6], -960, 3240);
camera_set_view_size(view_camera[6], 960, 540);

// view 7: Final Camera.
camera_set_view_pos(view_camera[7], -960, 3780);
camera_set_view_size(view_camera[7], 960, 540);

camera_set_begin_script(view_camera[0], function(){
	camera_set_view_pos(view_camera[0], global.playerOverworld.x - (camera_get_view_width(view_camera[0]) / 2), global.playerOverworld.y - (camera_get_view_height(view_camera[0]) / 2) - room_height);
	if (!surface_exists(mixSurface)){
		mixSurface = surface_create(960, 540, surface_r8unorm);
	}
	
	view_surface_id[0] = mixSurface;
	
	global.drawY = 0 * 540; // We would use current_view * 540, but on the HTML 5 export, the current_view variable is updated after the begin script for some dumb reason.
});

camera_set_begin_script(view_camera[1], function(){
	camera_set_view_pos(view_camera[1], global.playerOverworld.x - (camera_get_view_width(view_camera[1]) / 2), global.playerOverworld.y - (camera_get_view_height(view_camera[1]) / 2));
	
	if (!surface_exists(normalSurface)){
		normalSurface = surface_create(960, 540);
	}
	//layer_background_visible(layer_background_get_id("Background"), false);
	
	draw_clear_alpha(c_black, 0);
	view_surface_id[1] = normalSurface;
	
	global.drawY = 1 * 540; // We would use current_view * 540, but on the HTML 5 export, the current_view variable is updated after the begin script for some dumb reason.
});

camera_set_begin_script(view_camera[2], function(){
	camera_set_view_pos(view_camera[2], global.playerOverworld.x - (camera_get_view_width(view_camera[1]) / 2), global.playerOverworld.y - (camera_get_view_height(view_camera[2]) / 2) + room_height);

	if (!surface_exists(corruptSurface)){
		corruptSurface = surface_create(960, 540);
	}
	//layer_background_visible(layer_background_get_id("Background"), false);
	
	view_surface_id[2] = corruptSurface;
	draw_clear_alpha(c_black, 0);
	
	global.drawY = 2 * 540; // We would use current_view * 540, but on the HTML 5 export, the current_view variable is updated after the begin script for some dumb reason.
});

camera_set_begin_script(view_camera[3], function(){
	if (!surface_exists(overworldSurface)){
		overworldSurface = surface_create(960, 540);	
	}
	//layer_background_visible(layer_background_get_id("Background"), false);
	
	view_surface_id[3] = overworldSurface;
	
	global.drawY = 3 * 540; // We would use current_view * 540, but on the HTML 5 export, the current_view variable is updated after the begin script for some dumb reason.
});

camera_set_begin_script(view_camera[4], function(){
	if (!surface_exists(battleSurface)){
		battleSurface = surface_create(960, 540);	
	}
	
	view_surface_id[4] = battleSurface;
	
	global.drawY = 4 * 540; // We would use current_view * 540, but on the HTML 5 export, the current_view variable is updated after the begin script for some dumb reason.
});

camera_set_begin_script(view_camera[7], function(){
	//layer_background_visible(layer_background_get_id("Background"), true);
	global.drawY = 7 * 540; // We would use current_view * 540, but on the HTML 5 export, the current_view variable is updated after the begin script for some dumb reason.
	draw_text(global.drawX + 20, global.drawY + 20, global.drawY);
});