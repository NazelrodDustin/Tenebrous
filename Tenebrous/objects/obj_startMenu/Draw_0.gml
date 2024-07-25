/// @description Insert description here
// You can write your code in this editor

if (view_current == 7){
	if (!surface_exists(menuSurface)){
		menuSurface = surface_create(960, 540);
	}

	if (surface_exists(menuSurface)){
		surface_set_target(menuSurface);
		var alpha = clamp(1000 - timeOnScreen, 0, 1000) / 1000;
		draw_clear_alpha(global.grassCorruptedBaseColor, alpha);
		draw_set_alpha(1 - alpha);
		draw_sprite(spr_controls, 0 + (keyboard_check_direct(ord("Q")) ? 6 : 0), 96, 288 - screenOffset);
		draw_sprite(spr_controls, 1 + (keyboard_check_direct(ord("W")) ? 6 : 0), 96 + 72, 288 - screenOffset);
		draw_sprite(spr_controls, 2 + (keyboard_check_direct(ord("E")) ? 6 : 0), 96 + 72 + 72, 288 - screenOffset);
		draw_sprite(spr_controls, 3 + (keyboard_check_direct(ord("A")) ? 6 : 0), 112, 288 + 64 - screenOffset);
		draw_sprite(spr_controls, 4 + (keyboard_check_direct(ord("S")) ? 6 : 0), 112 + 72, 288 + 64 - screenOffset);
		draw_sprite(spr_controls, 5 + (keyboard_check_direct(ord("D")) ? 6 : 0), 112 + 72 + 72, 288 + 64 - screenOffset);


		draw_sprite(spr_controlLines, (timeOnScreen > 5000 ? ((timeOnScreen % 1000 > 500) || started) + 1 : 0), 0, 0 - screenOffset);
		draw_set_alpha(1);
		surface_reset_target();
	
		draw_surface(menuSurface, room_width, 1620);
	}
}