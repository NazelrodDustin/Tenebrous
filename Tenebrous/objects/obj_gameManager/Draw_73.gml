draw_set_color(c_black);

if (view_current == 7){
	if (inBattle && surface_exists(battleSurface)){
		draw_surface(battleSurface, 2048, 1620);
	}

	if (inOverworld && surface_exists(overworldSurface)){
		draw_surface_part(overworldSurface, 0, (surface_get_height(overworldSurface) / 2) - ((surface_get_height(overworldSurface) / 2) - (overworldSurfacePosition / 2)), 960, 540, 2048, 1620 + overworldSurfacePosition);	
	}
}