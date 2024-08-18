/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
waitTime = 0
targetPosition = []
collisionList = [obj_playerBlock, obj_house, obj_well];
noMovementCount = 0;
moveSpeed = 3;
image_speed = 0.5;
image_index = irandom(7);

function setTarget(){
	waitTime = random_range(5000, 7500);
	targetPosition = [irandom_range(128, room_width - 128), irandom_range(128, room_height - 128)];
	
	checkSize = 1;
}

setTarget();
difficulty = encounterSize * 0.025;