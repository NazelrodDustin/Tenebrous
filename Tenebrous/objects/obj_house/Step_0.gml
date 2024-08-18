/// @description Insert description here
// You can write your code in this editor

var pl = collision_rectangle(x - 120, y - (8 + 88), x + 120, y - (312 - 64), obj_playerOverworld, false, true);

if (pl == noone){
	pl = collision_rectangle(x - 80, y - (8 + 88), x + 80,  y - (25), obj_playerOverworld, false, true);
}

if (pl != noone){
	pl.x = x + irandom_range(-129, 129);
	pl.y = y + irandom_range(10, 20);
}


pl = collision_rectangle(x - 120, y - (8 + 88), x + 120, y - (312 - 64), obj_enemyPortal, false, true);

if (pl == noone){
	pl = collision_rectangle(x - 80, y - (8 + 88), x + 80,  y - (25), obj_enemyPortal, false, true);
}

if (pl != noone){
	other.x = x + irandom_range(-129, 129);
	other.y = y + irandom_range(10, 20);
}