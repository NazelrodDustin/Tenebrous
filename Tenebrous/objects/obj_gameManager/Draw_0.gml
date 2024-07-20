/// @description Insert description here
// You can write your code in this editor


if (view_current == 4){
	draw_set_color(battleBG);
	draw_rectangle(2048, -64, 2048 + 960, 540, false);	
	
	
	draw_set_color(c_white);
	part_system_drawit(battlePartSystemTop);
	part_system_drawit(battlePartSystemBottom);
	
}