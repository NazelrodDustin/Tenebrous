
moveSpeed = 6;
collisionList = [obj_playerBlock, obj_house, obj_well];
image_speed = 0;

interacted = noone;

xOffset = 0;
yOffset = 0;
rotation = 0;
footStepPlayed = true;
moving = false;
movementProgress = 0;

attackOffset = [26, -50];


soundFootStep = new soundEffect("snd_footstep", global.sfxLevel, .1, .01);
damageTimeSource = noone;

alive = true;
maxHp = 100;
hp = maxHp;
hpInterp = hp;

hpRegen = maxHp * 0.05;

hasAttacked = false;
entrancePlayed = false
attackSoundPlayed = false;
releaseSoundPlayed = false;
resultSoundPlayed = false;
target = noone;
manaRegen = false;
manaMax = 25;
manaCurrent = manaMax;
manaAfter = manaCurrent;
spellDamageBase = 1;
spellDamageRange = 0.1
blockLvl = 0.2;
hitLvl = 1;



function doHeal(_amount){
	hp += _amount;
	
	if (hp > maxHp){
		hp = maxHp;
	}
	
	hpInterp = hp;
}

function doDamage(_amount){
	if (alive){
		hp -= _amount;
		if (hp <= 0){
			alive = false;
			hp = 0;
			startDeath();
		}
		global.healthAmt = hp / maxHp;
		if (hpInterp != 0){
			showDamage();
			global.initiative += 1;
			
			if (global.initiative > instance_number(obj_enemy)){
				global.initiative = 0;	
			}
		}
	}
}

function showDamage(){
	if (time_source_exists(damageTimeSource)){
		time_source_destroy(damageTimeSource)
	}
	
	damageTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
		hpInterp--;
		if (hpInterp < 0){
			hpInterp = 0;	
		}
		global.healthInterp = hpInterp / maxHp;
	}, [], max(1, hpInterp - max(hp, 0)));
	
	time_source_start(damageTimeSource);
}

function startDeath(){
	audio_play_sound(snd_deathRiser, 0, false, global.sfxLevel);
	sprite_index = noone;//spr_playerDead;
	image_speed = 0.1;
	global.gameManager.doDeathScene();
	time_source_start(time_source_create(time_source_global, 10, time_source_units_seconds, function(){
		image_alpha = 0;
		image_speed = 0;
	}));
}

global.healthAmt = 1;
global.healthInterp = 1;

global.manaCurrent = 1;
global.manaAfter = 1;


attackTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
	
	if (!attackSoundPlayed){
		global.charge.play(0, 0, true);
		switch(global.spell){
			case 0:
				global.spellColor = c_red;
				break;
			
			case 1:
				global.spellColor = c_orange;
				break;
			
			case 2:
				global.spellColor = c_teal;
				break;
		}
		
		//show_debug_message("Attack Charge Played");
		attackSoundPlayed = true;
	}
	
	if (current_time - time_started < 2500){
		global.spellAlpha = min(1, ((current_time - time_started) / 750));
	}
	
	if (current_time - time_started > 2500 && !releaseSoundPlayed){
		global.release.play(0, 0, true);
		//show_debug_message("Attack Released Played");
		releaseSoundPlayed = true;
	}
	if (instance_exists(target)){
	
		//show_debug_message((current_time - time_started) - 2500);
		var percent = min(500, max(0, (current_time - time_started) - 2500)) / 500;
		var dist = 0;
		var angle = 0;
	
		dist = point_distance(global.playerBattle.x + attackOffset[0], global.playerBattle.y + attackOffset[1], target.x, target.y);
		angle = point_direction(global.playerBattle.x + attackOffset[0], global.playerBattle.y + attackOffset[1], target.x, target.y);
	
		//show_debug_message(target);
	
		global.spellPosition = [global.playerBattle.x + attackOffset[0] + lengthdir_x(dist * percent, angle), global.playerBattle.y + attackOffset[1] + lengthdir_y(dist * percent, angle)];
		//show_debug_message(string("My Position: {0}, Target Position: {1}, Spell Position: {2}, Percent: {3}, Distance {4}, Angle {5}", [global.playerBattle.x, global.playerBattle.y], [target.x, target.y], global.spellPosition, percent, dist, angle));
		if (current_time - time_started > 3000){
			if (!resultSoundPlayed){
				resultSoundPlayed = true;	
			}
		
			global.spellAlpha = min(1, 1 - (((current_time - time_started) - 3000) / 250));
		
			if (global.spellAlpha <= 0){
				if (random(target.blockLvl) < random(hitLvl)){
					if (global.spell == 0){
						target.doDamage(random_range(spellDamageBase, spellDamageBase + spellDamageRange));	
						//show_debug_message("Attack Damage Played");
						global.damage.play(0, 0, true);
					}else{
						target.doConfused();
						//show_debug_message("Attack Confused Played");
						global.confusion.play(0, 0, true);
					}
				}else{
					//show_debug_message("Attack Block Played");
					global.block.play(0, 0, true);	
				
					global.initiative += 1;
			
					if (global.initiative > instance_number(obj_enemy)){
						global.initiative = 0;	
					}
				}
				global.spellAlpha = 0;
				hasAttacked = false;
				attackSoundPlayed = false;
				releaseSoundPlayed = false;
				resultSoundPlayed = false;
				target = noone;
				time_started = -1;
			
				time_source_stop(attackTimeSource);	
			}
		}
	}else{
		global.spellAlpha = 0;
		hasAttacked = false;
		attackSoundPlayed = false;
		releaseSoundPlayed = false;
		resultSoundPlayed = false;
		target = noone;
		time_started = -1;
			
		time_source_stop(attackTimeSource);
	}
	
}, [], -1);

function doAttack(){
	time_started = current_time;
	time_source_start(attackTimeSource);
}
