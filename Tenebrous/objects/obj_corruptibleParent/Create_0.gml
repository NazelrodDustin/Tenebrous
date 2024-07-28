/// @description Insert description here
// You can write your code in this editor


isVisible = true;

corruptionSize = 5;
corruptionPartSystem = part_system_create(ps_corruption);
part_system_position(corruptionPartSystem, 0, 0);
part_emitter_region(corruptionPartSystem, 0, -1, 1, -1, 1, ps_shape_ellipse, ps_distr_linear);
part_emitter_stream(corruptionPartSystem, 0, scr_makeCorruptParticle(corruptionSize), 1);
part_system_automatic_draw(corruptionPartSystem, false);
part_system_automatic_update(corruptionPartSystem, false);