/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (!corrupted){
	instance_destroy();	
}

randomize();
var premoveX = x;
var premoveY = y;

if (waitTime > 0){
	waitTime -= global.deltaTime * 1000;
}else{
	var xAmt = (targetPosition[0] - x);
	var yAmt = (targetPosition[1] - y);
	
	var dir = point_direction(0, 0, xAmt, yAmt);

	if (!global.pauseOverworld && (xAmt != 0 || yAmt != 0)){
		var xMove = lengthdir_x(moveSpeed, dir);
		var yMove = lengthdir_y(moveSpeed, dir);
		
		move_and_collide(xMove, yMove, collisionList, 3);
	
		x = round(x);
		y = round(y);
	
		if (abs(premoveX - x) < 1 && abs(premoveY - y) < 1){
			//show_debug_message("No Path:");
			noMovementCount++;
			
			if (noMovementCount > 5){
				//show_debug_message("No Path: Setting New Target");
				setTarget();
				targetPosition = [room_width - targetPosition[0], room_height - targetPosition[1]];
				noMovementCount = 0;
			}
		}else{
			noMovementCount = 0;	
		}
	}
}

if ((abs(targetPosition[0] - x) < 4 && abs(targetPosition[1] - y) < 4)){
	setTarget();
}



