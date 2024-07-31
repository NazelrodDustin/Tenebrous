
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
		attackSoundPlayed = true;
	}
	
	if (current_time - time_started < 1000){
		spellAlpha = min(1, ((current_time - time_started) / 750));
	}
	
	if (current_time - time_started > 1000 && !releaseSoundPlayed){
		global.release.play(0, 0, true);
		attackSoundPlayed = true;
	}
	if (instance_exists(target)){
	global.spellAlpha = min(1, ((current_time - time_started) / 750));
	
	var percent = max(min(0, (current_time - time_started) - 1000), 500) / 500;
	
	var dist = point_distance(x, y, target.x, target.y);
	
	var angle = point_direction(x, y, target.x, target.y);
	
	global.spellPosition = [lengthdir_x(dist * percent, angle), lengthdir_y(dist * percent, angle)];
	
	if (current_time - time_started > 1500){
		if (!resultSoundPlayed){
			if (random(target.blockLvl) < random(hitLvl)){
				if (global.spell == 0){
					target.doDamage(random_range(spellDamageBase, spellDamageBase + spellDamageRange));		
					global.damage.play(0, 0, true);
				}else{
					target.doConfused();
					global.confusion.play(0, 0, true);
				}
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
	}else{
		spellAlpha = false;
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
