/// @description Insert description here
// You can write your code in this editor

event_inherited();
corruptionSize = 17.5;
encounterSize = irandom_range(2, 3);
difficulty = encounterSize * 0.025 * 1.5;
xOffset = 0;
yOffset = -160;


var spawnCount = irandom(2);

for (var i = 0; i < spawnCount; i++){
	
	var signX = ((irandom_range(-1, 1)) > 0 ? 1 : -1);
	var distanceX = irandom_range(128, 256) * signX;
	
	var signY = ((irandom_range(-1, 1)) > 0 ? 1 : -1);
	var distanceY = irandom_range(128, 256) * signY;
	
	var spawnX = x + signX;
	var spawnY = y + signY - (signY < 0 ? 320 : 0);

	instance_create_layer(spawnX, spawnY, "Instances", obj_enemyPortal);
}