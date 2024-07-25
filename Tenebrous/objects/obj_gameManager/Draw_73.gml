draw_set_color(c_black);

if (view_current == 7){
	
	draw_set_color(c_white);
	
	if (global.inBattle && surface_exists(battleSurface)){
		draw_surface(battleSurface, room_width, 1620);
	}

	if (inOverworld && surface_exists(overworldSurface)){
		draw_surface_part(overworldSurface, 0, (surface_get_height(overworldSurface) / 2) - ((surface_get_height(overworldSurface) / 2) - (overworldSurfacePosition / 2)), 960, 540, room_width, 1620 + overworldSurfacePosition);	
	}
	
	if (!window_has_focus()){
		var unfocused = "The game is unfocused. Input is not being captured!";
		draw_text(room_width + (960  / 2) - (string_width(unfocused) / 2), 1640, unfocused);
	}
	
	draw_text(room_width + 20, 1640, string("FPS: {0}", fps_real));
}