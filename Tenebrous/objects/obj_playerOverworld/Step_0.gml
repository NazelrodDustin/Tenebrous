var xAmt = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var yAmt = keyboard_check(ord("S")) - keyboard_check(ord("W"));

var dir = point_direction(0, 0, xAmt, yAmt);

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


	move_and_collide(xMove, yMove, collisionList);
	
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

if (global.inBattle){
	image_index = 2;
}

if (abs(yOffset) > 2 && soundPlayed){
	soundPlayed = false;	
}

if (abs(yOffset) < 0.25 && !soundPlayed){
	soundFootStep.play(x, y, true);
	soundPlayed = true;
}

audio_listener_position(x, y, 0);


