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
var houseCount = irandom_range(4, 6);
for (var i = 0; i < houseCount; i++){
	instance_create_layer(random_range(room_width / 2 - room_width / 4, room_width / 2 + room_width / 4), random_range(room_height / 2 - room_height / 4, room_height / 2 + room_height / 4), "Instances", obj_house);	
}
