
var xAmt = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var yAmt = keyboard_check(ord("S")) - keyboard_check(ord("W"));

var dir = point_direction(0, 0, xAmt, yAmt);

if (!alive){
	image_speed *= 1.01;	
}

if (!global.pauseOverworld && (xAmt != 0 || yAmt != 0)){
	moving = true;
	var xMove = lengthdir_x(moveSpeed, dir);
	var yMove = lengthdir_y(moveSpeed, dir);

	if (abs(xMove) <= abs(yMove)){
		if (yMove > 0){
			image_index = 0;	
		}else{
			image_index = 2;		
		}
	}else{
		if (xMove > 0){
			image_index = 1;	
		}else{
			image_index = 3;		
		}	
	}


	move_and_collide(xMove, yMove, collisionList, 3);
	
	x = round(x);
	y = round(y);
}else{
	moving = false;	
}

if (moving || (movementProgress % 1) > 0){
	movementProgress += 2 * global.deltaTime;
	yOffset = round(animcurve_channel_evaluate(animcurve_get_channel(anc_walk, "yOffset"), movementProgress / 2));
	if (image_index == 0 || image_index == 2){
		xOffset = animcurve_channel_evaluate(animcurve_get_channel(anc_walk, "xOffset"), movementProgress / 2);
		rotation = animcurve_channel_evaluate(animcurve_get_channel(anc_walk, "rotation"), movementProgress / 2);
	}else{
		xOffset = 0;
		rotation = 0;
	}
	
	if (movementProgress > 2){
		movementProgress = movementProgress % 2;

	}
	
	if (!moving && movementProgress % 1 < 0.05){
		movementProgress = floor(movementProgress);
	}
}

if (global.inBattle && alive){
	image_index = 2;
	if (instance_number(obj_enemy) > 0 && global.enemiesSpawed){
		if (global.initiative != 0){
			regen = false;	
		}
	
		if (!regen && global.initiative == 0){
			
			hp += hpRegen;
			hp = min (hp, maxHp);
			hpInterp = hp;
			
			global.healthAmt = hp / maxHp;
			global.healthInterp = hpInterp / maxHp;
			
			manaCurrent += manaRegen;
			manaCurrent = min(manaCurrent, manaMax);
			manaAfter = manaCurrent;
			regen = true;
		}
	
		if (!hasAttacked){
			if (global.initiative == 0){
				if (!global.spellSelected){
					global.spell += keyboard_check_released(ord("S")) - keyboard_check_released(ord("W"));
		
					if (global.spell < 0){
						global.spell = 2;	
					}
		
					if (global.spell > 2){
						global.spell = 0;	
					}
			
					if (global.spell == 2){
						hpInterp = min(hp + (((manaCurrent * 10) * 6) / 2), maxHp);
						manaAfter = manaCurrent - ceil((((hpInterp - hp) / 10) / 6) * 2);
					}else{
						hpInterp = hp;
				
						if (global.spell == 1){
							manaAfter = manaCurrent - 10;	
						}else{
							manaAfter = manaCurrent - 5;	
						}
					}
				
					global.healthInterp = hpInterp / maxHp;
			
					if (manaAfter >= 0 && keyboard_check_released(ord("E"))){
						global.spellSelected = true;
					}
			
				}else{
					if (global.spell == 2){
						hpInterp = min(hp + (((manaCurrent * 10) * 6) / 2), maxHp);
						manaAfter = manaCurrent - ceil((((hpInterp - hp) / 10) / 6) * 2);
				
						if (hpInterp - hp == 0){
							global.spellSelected = false;
						}else{
							target = id;
							doAttack();
							hasAttacked = true;
							global.spellCasted = true;
							
						}
					}else{
				
						if (global.spell == 1){
							manaAfter = manaCurrent - 10;	
						}else{
							manaAfter = manaCurrent - 5;	
						}
				
						global.selectedEnemy += keyboard_check_released(ord("A")) - keyboard_check_released(ord("D"));
				
						if (global.selectedEnemy < 1){
							global.selectedEnemy = instance_number(obj_enemy);
							
						}
				
						if (global.selectedEnemy > instance_number(obj_enemy)){
							global.selectedEnemy = 1;
						}
				
						if (keyboard_check_released(ord("E"))){
							with (obj_enemy){
								if (initiative == global.selectedEnemy){
									other.target = id;	
								}
							}
					
							manaCurrent = manaAfter;
					
							doAttack();
							hasAttacked = true;
							global.spellCasted = true;
						}
				
						if (keyboard_check_released(ord("Q"))){
							global.spellSelected = false;
						}
					}
			
				}
			}else{
				global.spellCasted = false;
				global.spellSelected = 0;
				global.spell = 0;
			}
		}
	}else{
		if (global.gameManager.battleUpgradeOffset <= 0 && global.enemiesSpawed){
			if (instance_exists(interacted)){
				if (interacted.corrupted){
					interacted.clearCorruption();
					global.gameManager.showUpgrades();
				}
			}else{
				show_debug_message("The current targeted interactable has been destroyed");	
			}
		}	
	}
	
}else{
	
	interacted = noone;
	
	with (obj_corruptibleParent){
		
		if (object_get_name(object_index) == "obj_well"){
		
			if (getCorruptedCount() > 1){
				continue;	
			}
		}
		
		if (corrupted){
			if (other.interacted == noone){
				other.interacted = id;
			}else{
				if (point_distance(other.x, other.y, x, y) < point_distance(other.x, other.y, other.interacted.x, other.interacted.y)){
					other.interacted = id;	
				}
			}
		}else{
			if (object_get_name(object_index) == "obj_well"){
				other.interacted = id;
			}
		}
	}
	
	if (interacted != noone){
		if (point_distance(x, y, interacted.x, interacted.y) > 256){
			interacted = noone;	
		}else{
			if keyboard_check_released(ord("E")){	
				if (interacted.corrupted){
					global.gameManager.showBattle(interacted.encounterSize);
				}else{
					global.gameManager.transition(function(){
						room_goto(rm_overworld);
						time_source_start(time_source_create(time_source_global, 1, time_source_units_frames, function(){
							global.roomsCleared++;
							instance_create_layer(0, 0, "Instances", obj_overworldRoomManager);
						}));
					});	
				}
			}
		}			
	}
}

if (abs(yOffset) > 2 && footStepPlayed){
	footStepPlayed = false;	
}

if (abs(yOffset) < 0.25 && !footStepPlayed){
	soundFootStep.play(x, y, true);
	footStepPlayed = true;
}

audio_listener_position(x, y, 0);

global.manaCurrent = manaCurrent / manaMax;
global.manaAfter = manaAfter / manaMax;
