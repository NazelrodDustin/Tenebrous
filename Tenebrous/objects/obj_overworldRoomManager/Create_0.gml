/// @description Insert description here
// You can write your code in this editor

worldTiles = array_create(0);

surfaceGrassNormal = noone;
surfaceGrassCorrupt = noone;

for (var i = 0; i < room_width / 64; i++){
	for (var j = 0; j < room_height / 64; j++){
		
		var seed = 1024;
		seed += i;
		seed = seed << 2;
		seed += j;
		seed = seed << 2;
		seed -= i;
		seed = seed << 2;
		seed -= j;
		seed = seed << 2;
		random_set_seed(seed);
		/// Fill array		image Index, xOffset						yOffset,		  rotation,		hFlip,			vFlip
		worldTiles[i][j] = [irandom(63), irandom_range(-63, 63), irandom_range(-63, 63), irandom(360), random(1) > .5, random(1) > .5];
	}
}