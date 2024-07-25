/// @description Insert description here
// You can write your code in this editor

worldTiles = array_create(0);

surfaceGrassNormal = noone;
surfaceGrassCorrupt = noone;
surfaceCorruptMix = noone;

for (var i = 0; i < room_width / 64; i++){
	for (var j = 0; j < room_height / 64; j++){
		
		var seed = 1024;
		seed += i;
		seed = seed << 5;
		seed += j;
		seed = seed << 6;
		seed -= i;
		seed = seed << 7;
		seed -= j;
		seed = seed << 8;
		random_set_seed(seed);
		/// Fill array		image Index, xOffset						yOffset,		  rotation,		hFlip,			vFlip
		worldTiles[i][j] = [irandom(63), irandom_range(-63, 63), irandom_range(-63, 63), irandom(360), random(1) > .5, random(1) > .5];
		
	}
}

for (var i = 0; i < room_width / 512; i++){
	for (var j = 0; j < room_height / 512; j++){
		instance_create_depth(i * 512 + 256, j * 512 + 256, 0, obj_test);
	}
}
