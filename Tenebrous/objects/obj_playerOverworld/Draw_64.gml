draw_set_font(fnt_robotomono);


var seed = 0;

if (instance_exists(obj_overworldRoomManager)){
	seed = obj_overworldRoomManager.seed;
}

//var location = string("Player location: ({0}, {1})\nMana: {2}, Post Choice Mana: {3}\nHealth: {4}, Health Interp: {5}\nDifficulty: {6}, Seed: {7}", x, y, manaCurrent, manaAfter, hp, hpInterp, global.difficulty, seed);
//draw_text(20, 20, location);