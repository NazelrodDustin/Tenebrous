/// @description Insert description here
// You can write your code in this editor

if (x <= 0 || x >= room_width){
	hspeed *= -1
}

if (y <= 0 || y >= room_height){
	vspeed *= -1
}



part_system_update(corruptionPartSystem);
part_emitter_region(corruptionPartSystem, 0, x - radius, x + radius, y - radius, y + radius, ps_shape_ellipse, ps_distr_invgaussian);