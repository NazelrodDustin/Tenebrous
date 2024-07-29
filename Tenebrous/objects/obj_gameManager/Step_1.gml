global.deltaTime = delta_time / 1000000;

if (global.inBattle){
	battleBGSpriteRotation += 10 * global.deltaTime;
}

if (global.lastBW != browser_width || global.lastBH != browser_height){
	window_set_size(browser_width, browser_height);
	surface_resize(application_surface, browser_width, browser_height);

	view_wport[7] = browser_width;
	view_hport[7] = browser_height;
	
	global.lastBW = browser_width;
	global.lastBW = browser_height;
}
global.cameraPercentCorrupt = averageArray(corruptionValues);



with (all){
		
}

