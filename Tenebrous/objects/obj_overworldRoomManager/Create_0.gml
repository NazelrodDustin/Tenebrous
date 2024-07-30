/// @description Insert description here
// You can write your code in this editor

worldTiles = array_create(0);

surfaceGrassNormal = noone;
surfaceGrassCorrupt = noone;
surfaceCorruptMix = noone;

sprite_index = noone;

random_set_seed(global.seed);
seed = global.roomsCleared * irandom_range(-8192, 8192);


for (var i = 0; i < room_width / 64; i++){
	for (var j = 0; j < room_height / 64; j++){
		var grassSeed = seed;
		grassSeed += i;
		grassSeed = grassSeed << 5;
		grassSeed += j;
		grassSeed = grassSeed << 6;
		grassSeed -= i;
		grassSeed = grassSeed << 7;
		grassSeed -= j;
		grassSeed = grassSeed << 8; 
		random_set_seed(grassSeed);
		/// Fill array		image Index, xOffset						yOffset,		  rotation,		hFlip,			vFlip
		worldTiles[i][j] = [irandom(63), irandom_range(-63, 63), irandom_range(-63, 63), irandom(360), random(1) > .5, random(1) > .5];
		
	}
}

random_set_seed(seed)


var leftCenter = (room_width / 2 - room_width / 4);
var rightCenter = (room_width / 2 + room_width / 4);
var topMiddle = (room_height / 2 - room_height / 4);
var bottomMiddle = (room_height / 2 + room_height / 4);

var variance = room_height / 8;




instance_create_layer(room_width / 2 + irandom_range(-variance, variance), room_height / 2 + irandom_range(-variance, variance), "Instances", obj_well);

instance_create_layer(leftCenter + irandom_range(-variance, variance), topMiddle + irandom_range(-variance, variance), "Instances", obj_house);	
instance_create_layer(rightCenter + irandom_range(-variance, variance), topMiddle + irandom_range(-variance, variance), "Instances", obj_house);	
instance_create_layer(leftCenter + irandom_range(-variance, variance), bottomMiddle + irandom_range(-variance, variance), "Instances", obj_house);	
instance_create_layer(rightCenter + irandom_range(-variance, variance), bottomMiddle + irandom_range(-variance, variance), "Instances", obj_house);
	
	


global.playerOverworld.x = random_range(room_width / 2 - room_width / 4, room_width / 2 + room_width / 4);
global.playerOverworld.y = random_range(room_height / 2 - room_height / 4, room_height / 2 + room_height / 4);


