/// @description Insert description here
// You can write your code in this editor

if (!started){
	global.gameManager.transition(function(){
		room_goto(rm_overworld);
		time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function(){
			instance_create_layer(0, 0, "Instances", obj_overworldRoomManager);	
		}));
	});
	started = true;
}