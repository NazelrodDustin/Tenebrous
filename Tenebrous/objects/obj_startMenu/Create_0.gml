/// @description Insert description here
// You can write your code in this editor

timeOnScreen = 0;
started = false;
menuSurface = noone;
screenOffset = 40;


if (instance_exists(global.gameManager)){
	global.gameManager.reset();
}