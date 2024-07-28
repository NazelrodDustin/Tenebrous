function scr_makeCorruptParticle(size = 5){

//Emitter
var _ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_explosion);
part_type_size(_ptype1, size, size, -0.0375, 0);
part_type_scale(_ptype1, 1.1, 1);
part_type_speed(_ptype1, 0, 0, 0.001, 0);
part_type_direction(_ptype1, 0, 360, 0, 0);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 0, 360, 0.01, 0, false);
part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ptype1, 0.25, 1, 0.5);
part_type_blend(_ptype1, true);
part_type_life(_ptype1, 30, 30);

return _ptype1;

}