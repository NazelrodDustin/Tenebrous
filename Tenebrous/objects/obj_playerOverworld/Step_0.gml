
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
	
	if (!manaRegen){
		manaCurrent += 5;
		manaCurrent = min(manaCurrent, manaMax);
		manaAfter = manaCurrent;
		manaRegen = true;
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
				global.spell = 0;

			
				if (global.spell == 2){
					hpInterp = max(hp + manaCurrent, maxHp);
					manaAfter = manaCurrent - (hpInterp - hp);
				}else{
					hpInterp = hp;
				
					if (global.spell == 1){
						manaAfter = manaCurrent - 5;	
					}else{
						manaAfter = manaCurrent - 2.5;	
					}
				}
			
				if (manaAfter >= 0 && keyboard_check_released(ord("E"))){
					global.spellSelected = true;
				}
			
			}else{
				if (global.spell == 2){
					hpInterp = min(hp + manaCurrent, maxHp);
					manaAfter = manaCurrent - (hpInterp - hp);
				
					if (hpInterp - hp == 0){
						global.spellSelected = false;
					}else{
						doHeal(hpInterp - hp);
						manaCurrent = manaAfter;
					}
				}else{
				
					if (global.spell == 1){
						manaAfter = manaCurrent - 5;	
					}else{
						manaAfter = manaCurrent - 2.5;	
					}
				
					global.selectedEnemy += keyboard_check_released(ord("A")) - keyboard_check_released(ord("S"));
				
					if (global.selectedEnemy < 1){
						global.selectedEnemy = 1;	
					}
				
					if (global.selectedEnemy > instance_number(obj_enemy)){
						global.selectedEnemy = instance_number(obj_enemy);
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
					}
				
					if (keyboard_check_released(ord("Q"))){
						global.spellSelected = false;
					}
				}
			
			}
		}else{
			global.spellSelected = 0;
			global.spell = 0;
		}
	}else{
		manaRegen = false;
		global.selectedEnemy = 0;	
	}
	
	if (instance_number(obj_enemy) == 0 && global.gameManager.battleBGSpriteScale >= 1){
		interacted.corrupted = false;
		global.gameManager.removeBattle();
	}
	
}else{
	
	ds_list_clear(interactList);
	collision_rectangle_list(x - 128, y - 128, x + 128, y + 128, obj_corruptibleParent, false, false, interactList, true);	
	
	
	
	
	if (ds_list_size(interactList) > 0){
		if keyboard_check_released(ord("E")){
			global.gameManager.showBattle(interactList[| 0].encounterSize);
			interacted = interactList[| 0];
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
