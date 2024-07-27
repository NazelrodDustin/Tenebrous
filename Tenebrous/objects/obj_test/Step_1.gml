/// @description Insert description here
// You can write your code in this editor

if (x <= 0 || x >= room_width){
	hspeed *= -1
}

if (y <= 0 || y >= room_height){
	vspeed *= -1
}


visible = point_in_rectangle(x, y, camera_get_view_x(view_camera[1]) - 192, camera_get_view_y(view_camera[1]) - 192, camera_get_view_x(view_camera[1]) + camera_get_view_width(view_camera[1]) + 192, camera_get_view_y(view_camera[1]) + camera_get_view_height(view_camera[1]) + 192);


part_emitter_region(corruptionPartSystem, 0, x - radius, x + radius, y - radius, y + radius, ps_shape_ellipse, ps_distr_invgaussian);
part_system_update(corruptionPartSystem);

part_emitter_enable(corruptionPartSystem, 0, visible);