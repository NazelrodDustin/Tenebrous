/// @description Insert description here
// You can write your code in this editor

maxHP = 10 * global.difficulty;
hp = maxHP;
spellDamageBase = 1 * global.difficulty;
spellDamageRange = 0.1 * global.difficulty;
blockLvl = 0.2 * global.difficulty;
hitLvl = 1 * global.difficulty;
roundsConfused = 0;
attackTargets = [];

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
spellAlpha = 0;
x = 0;
y = 0;

image_xscale = (random_range(-1, 1) < 0 ? -1 : 1);

soundEnter = new soundEffect("snd_enemySpawn", min(global.sfxLevel * 5, 1), .1, .01);

attackTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
	
	if (!attackSoundPlayed){
		global.charge.play(0, 0, true);
		attackSoundPlayed = true;
	}
	
	if (current_time - time_started < 1000){
		spellAlpha = min(1, ((current_time - time_started) / 750));
	}
	
	if (current_time - time_started > 1000 && !releaseSoundPlayed){
		global.release.play(0, 0, true);
		attackSoundPlayed = true;
	}
	
	global.spellAlpha = min(1, ((current_time - time_started) / 750));
	
	var percent = max(min(0, (current_time - time_started) - 1000), 500) / 500;
	
	var dist = point_distance(x, y, target.x, target.y);
	
	var angle = point_direction(x, y, target.x, target.y);
	
	global.spellPosition = [lengthdir_x(dist * percent, angle), lengthdir_y(dist * percent, angle)];
	
	if (current_time - time_started > 1500){
		if (!resultSoundPlayed){
			if (random(target.blockLvl) < random(hitLvl)){
				target.doDamage(random_range(spellDamageBase, spellDamageBase + spellDamageRange));		
				global.damage.play(0, 0, true);
			}else{
				global.block.play(0, 0, true);	
				
				global.initiative += 1;
			
				if (global.initiative > instance_number(obj_enemy)){
					global.initiative = 0;	
				}
			}
			
			resultSoundPlayed = true;	
		}
		
		spellAlpha = min(1, 1 - (((current_time - time_started) - 1500) / 250));
		
		if (spellAlpha <= 0){
			hasAttacked = false;
			attackSoundPlayed = false;
			releaseSoundPlayed = false;
			resultSoundPlayed = false;
			target = noone;
			time_started = -1;
			
			time_source_stop(attackTimeSource);	
		}
	}
	
}, [], -1);

function doAttack(){
	time_started = current_time;
	time_source_start(attackTimeSource);
}

function doConfused(){
	confused = true;
	
	global.initiative += 1;
			
	if (global.initiative > instance_number(obj_enemy)){
		global.initiative = 0;	
	}
}

function doDamage(_amount){

	hp -= _amount;
	show_debug_message(hp);
	global.initiative += 1;
			
	if (global.initiative > instance_number(obj_enemy)){
		global.initiative = 0;	
	}
	
	if (hp < 0){
		instance_destroy();	
	}
	
}
