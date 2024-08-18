
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
transitionOffset = 0;

attackOffset = [26, -50];


soundFootStep = new soundEffect("snd_footstep", global.sfxLevel, .1, .01);
hbSlow = new soundEffect("snd_heartbeatSlow", global.sfxLevel * 5, .1, .01);
hbMed = new soundEffect("snd_heartbeatMedium", global.sfxLevel * 5, .1, .01);
hbFast = new soundEffect("snd_heartbeatFast", global.sfxLevel * 5, .1, .01);
damageTimeSource = noone;

alive = true;

maxHp = 1000;
manaMax = 50;
hpRegen = 10;
manaRegen = 5;
critChance = 0.001;
critAmount = 1.5;
spellDamageBase = 25;
spellDamageRange = round(spellDamageBase * .2);
blockLvl = 0.2;
hitLvl = 1;

hasAttacked = false;
entrancePlayed = false
attackSoundPlayed = false;
releaseSoundPlayed = false;
resultSoundPlayed = false;
target = noone;
regen = false;
hp = maxHp;
hpInterp = hp;
manaCurrent = manaMax;
manaAfter = manaCurrent;

function doHeal(_amount){
	hp += _amount;
	
	if (hp > maxHp){
		hp = maxHp;
	}
	
	hpInterp = hp;
	global.healthAmt = hp / maxHp;
	global.healthInterp = hpInterp / maxHp;
}

function doDamage(_amount){
	if (alive){
		hp -= ceil(_amount);
		if (hp <= 0){
			alive = false;
			hp = 0;
			startDeath();
		}
		global.healthAmt = hp / maxHp;
		if (hpInterp != 0){
			showDamage();
			
			
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
		
		if (hpInterp == hp){
			passInitiative();	
		}
		
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
		if (global.spell != 2){
			global.charge.play(0, 0, true);
		}
		switch(global.spell){
			case 0:
				global.spellColor = make_color_rgb(165, 48, 48);
				break;
			
			case 1:
				global.spellColor = make_color_rgb(136 ,75, 43);
				break;
			
			case 2:
				global.spellColor = make_color_rgb(79, 143, 186);	
				break;
		}
		
		//show_debug_message("Attack Charge Played");
		attackSoundPlayed = true;
	}
	
	if (current_time - time_started < 2500){
		global.spellAlpha = min(1, ((current_time - time_started) / 750));
		if (((current_time - time_started) % 500) <= 16){
			hbFast.play(0, 0, true);
		}
	}
	
	if (current_time - time_started > 2500 && !releaseSoundPlayed){
		if (global.spell != 2){
			global.release.play(0, 0, true);
		}
		
		//show_debug_message("Attack Released Played");
		releaseSoundPlayed = true;
	}
	if (instance_exists(target)){
		if (current_time - time_started > 2500 && global.spell == 2){
			if (((current_time - time_started) % 900) <= 16){
				hbSlow.play(0, 0, true);
			}
		}
		//show_debug_message((current_time - time_started) - 2500);
		var percent = min(500, max(0, (current_time - time_started) - 2500)) / 500;
		var dist = 0;
		var angle = 0;
	
		dist = point_distance(global.playerBattle.x + attackOffset[0], global.playerBattle.y + attackOffset[1], target.x, target.y);
		angle = point_direction(global.playerBattle.x + attackOffset[0], global.playerBattle.y + attackOffset[1], target.x, target.y);
	
		if (target == id){
			dist = 0;	
		}
		//show_debug_message(target);
	
		global.spellPosition = [global.playerBattle.x + attackOffset[0] + lengthdir_x(dist * percent, angle), global.playerBattle.y + attackOffset[1] + lengthdir_y(dist * percent, angle)];
		//show_debug_message(string("My Position: {0}, Target Position: {1}, Spell Position: {2}, Percent: {3}, Distance {4}, Angle {5}", [global.playerBattle.x, global.playerBattle.y], [target.x, target.y], global.spellPosition, percent, dist, angle));
		if (current_time - time_started > 3000){
			if (!resultSoundPlayed){
				resultSoundPlayed = true;	
			}
		
			global.spellAlpha = min(1, 1 - (((current_time - time_started) - 3000) / 250));
		
			if (global.spellAlpha <= 0){
				var block = random(target.blockLvl);
				var hit = random(hitLvl);
				show_debug_message("Block vs Hit: {0} -> {1}, Does hit? {2}", block, hit, (block < hit ? "Yes" : "No"));
				if (block < hit || global.spell == 2){
					if (global.spell == 0){
						var crit = random(1) <= critChance;
						if (crit){
							var text = instance_create_layer(x, y - 48, "Instances", obj_textFade);
							text.text = "Blocked";
						}
						target.doDamage((spellDamageBase + irandom(spellDamageRange)) * (crit ? critAmount : 1));
						//show_debug_message("Attack Damage Played");
						global.damage.play(0, 0, true);
					}else if (global.spell == 1){
						target.doConfused();
						//show_debug_message("Attack Confused Played");
						global.confusion.play(0, 0, true);
					}else{
						hbFast.play(0, 0, true);	
						hpInterp = min(hp + (((manaCurrent * 10) * 6) / 2), maxHp);
						manaAfter = manaCurrent - ceil((((hpInterp - hp) / 10) / 6) * 2);
				
						doHeal(hpInterp - hp);
						manaCurrent = manaAfter;
					}
				}else{
					//show_debug_message("Attack Block Played");
					target.doBlock();
					global.block.play(0, 0, true);	
					
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

function doBlock(){
	global.playerBattle.doBlock();
	passInitiative();	
}

function doAttack(){
	time_started = current_time;
	time_source_start(attackTimeSource);
}

