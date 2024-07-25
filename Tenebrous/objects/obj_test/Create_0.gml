/// @description Insert description here
// You can write your code in this editor

radius = irandom_range(25, 50);

corruptionPartSystem = part_system_create(ps_corruption);
part_system_position(corruptionPartSystem, x, y);
part_emitter_region(corruptionPartSystem, 0, -radius, radius, -radius, radius, ps_shape_ellipse, ps_distr_invgaussian);
part_system_automatic_draw(corruptionPartSystem, false);