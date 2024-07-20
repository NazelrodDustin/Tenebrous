/// @description Insert description here
// You can write your code in this editor


// Reset all cameras to be in proper area.

// view 0: Overworld camera.
camera_set_view_pos(view_camera[0], 0, 0);
camera_set_view_size(view_camera[0], 960, 540);

camera_set_view_pos(view_camera[1], -960, 540);
camera_set_view_size(view_camera[1], 960, 540);

camera_set_view_pos(view_camera[2], -960, 1080);
camera_set_view_size(view_camera[2], 960, 540);

camera_set_view_pos(view_camera[3], -960, 1620);
camera_set_view_size(view_camera[3], 960, 540);

// view 4: Battle Infro Camera
camera_set_view_pos(view_camera[4], 2048, 0);
camera_set_view_size(view_camera[4], 960, 540);

camera_set_view_pos(view_camera[5], 2048, 540);
camera_set_view_size(view_camera[5], 960, 540);

camera_set_view_pos(view_camera[6], 2048, 1080);
camera_set_view_size(view_camera[6], 960, 540);

camera_set_view_pos(view_camera[7], 2048, 1620);
camera_set_view_size(view_camera[7], 960, 540);


camera_set_view_target(view_camera[0], global.playerOverworld);

camera_set_begin_script(view_camera[0], function(){
	if (!surface_exists(overworldSurface)){
		overworldSurface = surface_create(960, 540);	
	}
	
	view_surface_id[0] = overworldSurface;
});

camera_set_begin_script(view_camera[4], function(){
	if (!surface_exists(battleSurface)){
		battleSurface = surface_create(960, 540);	
	}
	
	view_surface_id[4] = battleSurface;
});