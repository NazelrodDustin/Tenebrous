draw_set_color(c_black);

if (view_current == 7){
	
	draw_set_color(c_white);
	
	if (global.inBattle && surface_exists(battleSurface)){
		draw_surface_part(battleSurface, 0, 0, 960, overworldSurfacePosition, global.drawX, global.drawY);
	}

	if (inOverworld && surface_exists(overworldSurface)){
		draw_surface_part(overworldSurface, 0, (surface_get_height(overworldSurface) / 2) - ((surface_get_height(overworldSurface) / 2) - (overworldSurfacePosition / 2)), 960, 540, global.drawX, global.drawY + overworldSurfacePosition);	
	}
	
	if (!window_has_focus()){
		var unfocused = "The game is unfocused. Input is not being captured!";
		draw_text(global.drawX + (960  / 2) - (string_width(unfocused) / 2), global.drawY + 20, unfocused);
	}
	
	draw_text(global.drawX + 20, global.drawY + 20, string("FPS: {0}", fps_real));
	
	draw_text(global.drawX + 20, global.drawY + 60, string("Corrupton: {0}%", global.cameraPercentCorrupt * 100));
}