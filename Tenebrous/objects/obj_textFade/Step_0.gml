/// @description Insert description here
// You can write your code in this editor

y -= 25 * global.deltaTime;
alpha -= 1 * global.deltaTime;

if (alpha <= 0){
	instance_destroy();	
}
