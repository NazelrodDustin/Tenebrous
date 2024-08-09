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
	image_speed = .25;
}else{
	image_speed = 0;
	image_index = 0;
}

if (scale >= 1 && initiative == global.initiative && !hasAttacked){
	
	attackTargets = [global.playerBattle];
	//show_debug_message("Enemy {0} confused", confused ? "is" : "is not");
	if (confused){
		with (obj_enemy){
			array_push(other.attackTargets, id);
		}
		roundsConfused++;
	}
	
	doAttack();
	hasAttacked = true;
	target = array_shuffle(attackTargets)[0];
	
	if (confused){
		var confusedChance = random(1);
		confused = !(confusedChance < .125 * roundsConfused);
		//show_debug_message("Enemy {0} confused after turn. Confused chance: {1} vs Confusion depth {2}", confused ? "is" : "is not", confusedChance, .125 * roundsConfused);
		if (!confused){
			roundsConfused = 0;	
		}
	}
}