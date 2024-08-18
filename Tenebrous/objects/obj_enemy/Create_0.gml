/// @description Insert description here
// You can write your code in this editor

maxHP = ceil(100 * global.difficulty);
hp = maxHP;
spellDamageBase = ceil(10 * global.difficulty);
spellDamageRange = ceil(5 * global.difficulty);
blockLvl = 0.2 * global.difficulty;
hitLvl = 1 * global.difficulty;
roundsConfused = 0;
attackTargets = [];
critChance = 0.001 * global.difficulty;
critAmount = max(1.0, 2.5 * global.difficulty);

time_started = 0;

confused = false;
position = [];
inTime = 0;
initiative = 0;
scale = 0;
hasAttacked = false;
entrancePlayed = false
attackSoundPlayed = false;
releaseSoundPlayed = false;
resultSoundPlayed = false;
initiative = 0;
target = noone;
x = 0;
y = 0;

image_xscale = (random_range(-1, 1) < 0 ? -1 : 1);

attackOffset = [image_xscale * -10, -32];


soundEnter = new soundEffect("snd_enemySpawn", min(global.sfxLevel * 5, 1), .1, .01);

attackTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
	
	if (!attackSoundPlayed){
		global.charge.play(0, 0, true);
		//show_debug_message("Attack Charge Played");
		global.spellColor = make_color_rgb(165, 48, 48);
		attackSoundPlayed = true;
	}
	
	if (current_time - time_started < 2500){
		global.spellAlpha = min(1, ((current_time - time_started) / 750));
	}
	
	if (current_time - time_started > 2500 && !releaseSoundPlayed){
		global.release.play(0, 0, true);
		//show_debug_message("Attack Release Played");
		releaseSoundPlayed = true;
	}
	
	var percent = min(500, max(0, (current_time - time_started) - 2500)) / 500;
	var dist = 0;
	var angle = 0;
	
	if (instance_exists(target)){
		dist = point_distance(x + attackOffset[0], y + attackOffset[1], target.x, target.y);
		angle = point_direction(x + attackOffset[0], y + attackOffset[1], target.x, target.y);
	}
	
	//show_debug_message(target);
	
	global.spellPosition = [x + attackOffset[0] + lengthdir_x(dist * percent, angle), y + attackOffset[1] + lengthdir_y(dist * percent, angle)];
	//show_debug_message(string("My Position: {0}, Target Position: {1}, Spell Position: {2}, Percent: {3}, Distance {4}, Angle {5}", [x, y], [target.x, target.y], global.spellPosition, percent, dist, angle));
	if (current_time - time_started > 3000){
		if (!resultSoundPlayed){			
			resultSoundPlayed = true;	
		}
		
		global.spellAlpha = min(1, 1 - (((current_time - time_started) - 3000) / 250));
		
		if (global.spellAlpha <= 0){
			
			
			if (target == global.playerBattle){
				target = global.playerOverworld;	
			}
			
			var block = random(target.blockLvl);
			var hit = random(hitLvl);
			show_debug_message("Block vs Hit: {0} -> {1}, Does hit? {2}", block, hit, (block < hit ? "Yes" : "No"));
			if (block < hit || (target == id)){
				
				var crit = random(1) <= critChance;
				if (crit){
					var text = instance_create_layer(x, y - 48, "Instances", obj_textFade);
					text.text = "Blocked";
				}
				target.doDamage((spellDamageBase + irandom(spellDamageRange)) * (crit ? critAmount : 1));
				global.damage.play(0, 0, true);
				//show_debug_message("Attack Damage Played");
			}else{
				target.doBlock();
				global.block.play(0, 0, true);	
				//show_debug_message("Attack Blocked Played");
			}
			
			if (target == global.playerOverworld){
				target = global.playerBattle;	
			}
			
			global.spellAlpha = 0;
			
			time_source_stop(attackTimeSource);	
		}
	}
	
}, [], -1);

function doAttack(){
	alarm[0] = 60;
}

function doConfused(){
	confused = true;
	
	passInitiative();
}

function doBlock(){
	var text = instance_create_layer(x, y - 48, "Instances", obj_textFade);
	text.text = "Blocked";
	passInitiative();	
}

function doDamage(_amount){

	hp -= ceil(_amount);
	//show_debug_message(hp);
	passInitiative();
	
	if (hp <= 0){
		instance_destroy();	
	}
	
}
