/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
randomize();
waitTime = random_range(5000, 7500);
targetPosition = [irandom_range(128, room_width - 128), irandom_range(128, room_height - 128)];
collisionList = [obj_playerBlock, obj_house, obj_well];
noMovementCount = 0;
checkSize = 1;
moveSpeed = 3;