/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
randomize();
premoveX = x;
premoveY = y;

if (waitTime > 0){
	waitTime -= global.deltaTime * 1000;
}else{
	var xAmt = (targetPosition[0] - x);
	var yAmt = (targetPosition[1] - y);
	
	var dir = point_direction(0, 0, xAmt, yAmt);

	if (!global.pauseOverworld && (xAmt != 0 || yAmt != 0)){
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
	
		if (abs(premoveX - x) < 2 && abs(premoveY - y) < 2){
			noMovementCount++;
	
			if (noMovementCount > 5){
				targetPosition = [room_width - targetPosition[0], room_height - targetPosition[1]];
				show_debug_message("No path: new location chosen");
			}
		}else{
			noMovementCount = 0;	
		}
	
		checkSize *= 1.0125;
		checkSize = min(checkSize, 128);
	}
}

if ((abs(targetPosition[0] - x) < 4 && abs(targetPosition[1] - y) < 4) || point_in_rectangle(obj_well.x, obj_well.y, x - checkSize, y - checkSize, x + checkSize, y + checkSize)){
	waitTime = random_range(5000, 7500);
	targetPosition = [irandom_range(128, room_width - 128), irandom_range(128, room_height - 128)];
	if (abs(targetPosition[0] - room_width / 2) < 96){
		targetPosition[0] = room_width / 2 * (sign(targetPosition[0] - room_width / 2) * 96);
	}
	
	if (abs(targetPosition[1] - room_height / 2) < 96){
		targetPosition[1] = room_height / 2 * (sign(targetPosition[0] - room_height / 2) * 96);
	}
	checkSize = 1;
}



