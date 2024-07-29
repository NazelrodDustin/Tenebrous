draw_set_color(c_black);

if (view_current == 7){
	
	draw_set_color(c_white);
	if (room != rm_startMenu){
		part_system_drawit(voidPartSystem);
	}
	
	if (global.inBattle && surface_exists(battleSurface)){
		draw_surface_part(battleSurface, 0, 0, 960, overworldSurfacePosition, global.drawX, global.drawY);
	}

	if (surface_exists(overworldSurface)){
		var xFix = global.playerOverworld.x - (960 / 2) < 0 ? ((960 / 2) - global.playerOverworld.x) : 0;
		var yFix = global.playerOverworld.y - (540 / 2) < 0 ? ((540 / 2) - global.playerOverworld.y) : 0;
		
		var wFix = global.playerOverworld.x + (960 / 2) > room_width ? room_width - global.playerOverworld.x + (960 / 2) : 960 - xFix;
		var hFix = global.playerOverworld.y + (540 / 2) > room_height ? room_height - global.playerOverworld.y + (540 / 2) : 540 - yFix;
		
		
		var yCenter = (surface_get_height(overworldSurface) / 2) - ((surface_get_height(overworldSurface) / 2) - (overworldSurfacePosition / 2));
		
		yFix = yCenter > yFix ? yCenter : yFix;  
		
		draw_surface_part(overworldSurface, xFix, yFix, wFix, hFix, global.drawX + xFix, global.drawY + yFix + (overworldSurfacePosition / 2));
		//draw_text(global.drawX + (960 - 260), global.drawY + 20, string("X Fixed: {0}, Y Fixed: {1}", xFix, yFix));
		//draw_text(global.drawX + (960 - 260), global.drawY + 40, string("W Fixed: {0}, H Fixed: {1}", wFix, hFix));
		//draw_text(global.drawX + (960 - 260), global.drawY + 60, string("Y Center: {0}", yCenter));
	}
	
	if (!window_has_focus()){
		var unfocused = "The game is unfocused. Input is not being captured!";
		draw_text(global.drawX + (960  / 2) - (string_width(unfocused) / 2), global.drawY + 20, unfocused);
	}
	
	//draw_text(global.drawX + 20, global.drawY + 20, string("FPS: {0}", fps_real));
	
	//draw_text(global.drawX + 20, global.drawY + 60, string("Corrupton: {0}%", global.cameraPercentCorrupt * 100));
}