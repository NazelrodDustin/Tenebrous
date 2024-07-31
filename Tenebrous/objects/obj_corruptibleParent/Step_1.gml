/// @description Insert description here
// You can write your code in this editor

isVisible = point_in_rectangle(x, y, camera_get_view_x(view_camera[1]) - (32 * corruptionSize), camera_get_view_y(view_camera[1]) - (32 * corruptionSize), camera_get_view_x(view_camera[1]) + camera_get_view_width(view_camera[1]) + (32 * corruptionSize), camera_get_view_y(view_camera[1]) + camera_get_view_height(view_camera[1]) + (32 * corruptionSize));

if (!corrupted){
	part_emitter_enable(corruptionPartSystem, 0, false);
}else{
	part_emitter_region(corruptionPartSystem, 0, x + xOffset, x + xOffset, y + yOffset, y + yOffset, ps_shape_ellipse, ps_distr_invgaussian);
}


part_system_update(corruptionPartSystem);

