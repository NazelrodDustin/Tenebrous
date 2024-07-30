/// @description Insert description here
// You can write your code in this editor

event_inherited();
corruptionSize = 17.5;
encounterSize = irandom_range(3,4);
xOffset = 0;
yOffset = -160;


var spawnCount = irandom(2);

for (var i = 0; i < spawnCount; i++){
	var spawnX = x + (irandom_range(128, 256) * ((irandom_range(-1, 1)) > 0 ? 1 : -1));
	var spawnY = y + (irandom_range(256, 512) * ((irandom_range(-1, 1)) > 0 ? 1 : -1));

	instance_create_layer(spawnX, spawnY, "Instances", obj_enemyPortal);
}