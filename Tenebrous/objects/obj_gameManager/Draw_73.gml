draw_set_color(c_black);

if (view_current == 7){
	
	draw_set_color(c_white);
	if (room != rm_startMenu){
		part_system_drawit(voidPartSystem);

		if (surface_exists(overworldSurface)){
			var xx = camera_get_view_x(view_camera[1]) + (960 / 2);
			var yy = camera_get_view_y(view_camera[1]) + (540 / 2);
			
			var xFix = xx - (960 / 2) < 0 ? ((960 / 2) - xx) : 0;
			var yFix = yy - (540 / 2) < 0 ? ((540 / 2) - yy) : 0;
		
			var wFix = xx + (960 / 2) > room_width ? room_width - xx + (960 / 2) : 960 - xFix;
			var hFix = yy + (540 / 2) > room_height ? room_height - yy + (540 / 2) : 540 - yFix;
		
		
			var yCenter = (surface_get_height(overworldSurface) / 2) - ((surface_get_height(overworldSurface) / 2) - (overworldSurfacePosition / 2));
		
			yFix = yCenter > yFix ? yCenter : yFix;  
		
			draw_surface_part(overworldSurface, xFix, yFix, wFix, hFix, global.drawX + xFix, global.drawY + yFix + (overworldSurfacePosition / 2));
			//draw_text(global.drawX + (960 - 260), global.drawY + 20, string("X Fixed: {0}, Y Fixed: {1}", xFix, yFix));
			//draw_text(global.drawX + (960 - 260), global.drawY + 40, string("W Fixed: {0}, H Fixed: {1}", wFix, hFix));
			//draw_text(global.drawX + (960 - 260), global.drawY + 60, string("Y Center: {0}", yCenter));
		}
	
	
	
		if (global.inBattle && surface_exists(battleSurface)){
			draw_set_alpha(battleUIAlpha);
			draw_healthbar(global.drawX + 771, global.drawY + battleUIPosition + 66, global.drawX + 907, global.drawY + battleUIPosition + 74, global.healthInterp * 100, make_color_rgb(9, 10, 20), make_color_rgb(117, 36, 56), make_color_rgb(117, 36, 56), 0, true, false);
			draw_healthbar(global.drawX + 771, global.drawY + battleUIPosition + 66, global.drawX + 907, global.drawY + battleUIPosition + 74, global.healthAmt * 100, c_black, make_color_rgb(165, 48, 48), make_color_rgb(165, 48, 48), 0, false, false);
			
			draw_healthbar(global.drawX + 771, global.drawY + battleUIPosition + 87, global.drawX + 907, global.drawY + battleUIPosition + 95, global.manaCurrent * 100, make_color_rgb(9, 10, 20), make_color_rgb(79, 143, 186), make_color_rgb(79, 143, 186), 0, true, false);
			draw_healthbar(global.drawX + 771, global.drawY + battleUIPosition + 87, global.drawX + 907, global.drawY + battleUIPosition + 95, global.manaAfter * 100, c_black, make_color_rgb(115, 190, 211), make_color_rgb(115, 190, 211), 0, false, false);
			
			draw_set_alpha(1);
			
			draw_sprite_ext(spr_battleUI, global.UIFrame, global.drawX, global.drawY + battleUIPosition, 1, 1, 0, c_white, battleUIAlpha);
			
			draw_surface_part(battleSurface, 0, 0, 960, overworldSurfacePosition, global.drawX, global.drawY);
			
			draw_sprite(spr_indicator, 0, global.drawX + (960 / 2), global.drawY + battleUpgradeOffset - 304);
			
			draw_sprite(spr_upgrade, 0, global.drawX + (960 / 2) - (960 / 4), global.drawY + battleUpgradeOffset);
			draw_sprite(spr_upgrade, 0, global.drawX + (960 / 2), global.drawY + battleUpgradeOffset);
			draw_sprite(spr_upgrade, 0, global.drawX + (960 / 2) + (960 / 4), global.drawY + battleUpgradeOffset);
			
			part_system_color(spellPartSystem, global.spellColor, global.spellAlpha);
			part_system_drawit(spellPartSystem);
			draw_sprite_ext(spr_circleFade, 0, global.drawX + (960 / 2) + global.spellPosition[0], global.drawY + (540 / 2) + global.spellPosition[1], .25, .25, 0, global.spellColor, global.spellAlpha); //
			
			with (obj_textFade){
				draw_set_color(c_white);
				draw_set_alpha(alpha);
				draw_text(global.drawX + (960 / 2) + x - (string_width(text) / 2) , global.drawY + (540 / 2) + y, text);	
				draw_set_alpha(1);
			}
		}

	}
	if (!window_has_focus()){
		var unfocused = "The game is unfocused. Input is not being captured!";
		draw_text(global.drawX + (960  / 2) - (string_width(unfocused) / 2), global.drawY + 20, unfocused);
	}
	
	//draw_text(global.drawX + 20, global.drawY + 20, string("FPS: {0}", fps_real));
	
	//draw_text(global.drawX + 20, global.drawY + 60, string("Corrupton: {0}%", global.cameraPercentCorrupt * 100));
}