// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function passInitiative(){
	global.initiative += 1;
			
	if (global.initiative > instance_number(obj_enemy)){
		global.initiative = 0;	
	}
}
