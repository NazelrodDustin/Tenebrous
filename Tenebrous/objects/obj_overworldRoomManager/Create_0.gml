/// @description Insert description here
// You can write your code in this editor

worldTiles = array_create(0);

surfaceGrassNormal = noone;
surfaceGrassCorrupt = noone;

for (var i = 0; i < room_width / 32; i++){
	for (var j = 0; j < room_height / 32; j++){
		/// Fill array		xIndex,		yIndex,		rotation,	hFlip,			vFlip
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
		worldTiles[i][j] = [irandom(7), irandom(7), irandom(3), random(1) > .5, random(1) > .5];
	}
}