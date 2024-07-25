/// @description Insert description here
// You can write your code in this editor

radius = 1; //irandom_range(64, 128);

corruptionPartSystem = part_system_create(ps_corruption);
part_system_position(corruptionPartSystem, 0, 0);
part_emitter_region(corruptionPartSystem, 0, -1, 1, -1, 1, ps_shape_ellipse, ps_distr_linear);
part_system_automatic_draw(corruptionPartSystem, false);
part_system_automatic_update(corruptionPartSystem, false);

hspeed = random_range(-2, 2);
vspeed = random_range(-2, 2);