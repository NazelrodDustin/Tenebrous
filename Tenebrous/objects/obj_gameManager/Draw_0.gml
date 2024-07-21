// Create Battle view;
if (view_current == 4){
	draw_set_color(battleBG);
	draw_rectangle(2048, -64, 2048 + 960, 540, false);	
	
	draw_set_color(c_white);
	
	if (!surface_exists(battlePartSurfaceTop)){
		battlePartSurfaceTop = surface_create(1024, 256);
	}
	
	surface_set_target(battlePartSurfaceTop);
	draw_clear_alpha(c_black, 0);
	part_system_drawit(battlePartSystemTop);
	surface_reset_target();
	
	if (!surface_exists(battlePartSurfaceBottom)){
		battlePartSurfaceBottom = surface_create(1024, 256);
	}
	
	surface_set_target(battlePartSurfaceBottom);
	draw_clear_alpha(c_black, 0);
	part_system_drawit(battlePartSystemBottom);
	surface_reset_target();
	
	draw_surface_ext(battlePartSurfaceTop, 2048 + 940 - 600 + battlePartSurfaceOffset, -256, 1, 1, -22.5, c_white, 1);
	draw_surface_ext(battlePartSurfaceTop, 2048 - battlePartSurfaceOffset, 100, 1, 1, -22.5, c_white, 1);
	
}