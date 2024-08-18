/// @description Insert description here
// You can write your code in this editor


with (obj_enemy){
	if (other.initiative < initiative){
		initiative--;	
	}
}

if (initiative == global.initiative - 1){
	global.initiative--;	
}

if (global.initiative > instance_number(obj_enemy) - 1){
	global.initiative = 0;	
}

if (initiative == global.selectedEnemy){
	global.selectedEnemy = 1;	
}