/// @description Insert description here
// You can write your code in this editor


isVisible = true;
corrupted = true;
encounterSize = irandom_range(1, 2);

corruptionSize = 3;
corruptionPartSystem = part_system_create(ps_corruption);

xOffset = 0;
yOffset = 0;


time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function(){
	part_system_position(corruptionPartSystem, 0, 0);
	part_emitter_region(corruptionPartSystem, 0, -1, 1, -1, 1, ps_shape_ellipse, ps_distr_linear);
	
	
	show_debug_message(corruptionSize);
	part_emitter_stream(corruptionPartSystem, 0, scr_makeCorruptParticle(corruptionSize), 1);
	part_system_automatic_draw(corruptionPartSystem, false);
	part_system_automatic_update(corruptionPartSystem, false);
}));


