/// @description Insert description here
// You can write your code in this editor

if (inTime < 0){
	inTime += global.deltaTime * 4000;	
}else{
	inTime = 0;	
}

if (scale > 0 && !entrancePlayed){
	soundEnter.play(x, y, true);
	entrancePlayed = true;
}

scale = 1 - min(1, -(inTime / 1000));

x = scale * position[0];
y = scale * position[1];


if (confused){
	image_speed = 0.25;	
}else{
	image_speed = 0;
	image_index = 0;
}


//show_debug_message(string("Scale: {0}, Initiative: {1}, Global: {2}, Has Attacked?: {3}", scale, initiative, global.initiative, hasAttacked ? "True" : "False"));

if (scale >= 1 && initiative == global.initiative && !hasAttacked){
	attackTargets = [global.playerOverworld];
	
	if (confused){
		with (obj_enemy){
			array_push(other.attackTargets, id);
		}
		roundsConfused++;
	}else{
		roundsConfused = 0;	
	}
	
	doAttack();
	hasAttacked = true;
	target = array_shuffle(attackTargets)[0];
	
	if (confused){
		confused = (random(1) < .125 * roundsConfused);	
	}
}