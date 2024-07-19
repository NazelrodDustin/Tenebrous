/// @description Insert description here
// You can write your code in this editor


var xAmt = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var yAmt = keyboard_check(ord("S")) - keyboard_check(ord("W"));

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


	move_and_collide(xMove, yMove, collisionList);
	
	x = round(x);
	y = round(y);
}