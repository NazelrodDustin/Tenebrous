/// @description Insert description here
// You can write your code in this editor

// Create an array of room arrays [x, y, room] 
global.roomList = array_create(1, [0, 0, rm_baseOverworld]);
global.deltaTime = delta_time / 1000000;
global.pauseGameplay = false;

global.playerOverworld = instance_create_depth(10, 10, 0, obj_playerOverworld);

fadeInPercent = 0.4;
fadeOutPercent = 0.5;
transitionAlpha = 0.0;
transitionStarted = false;
fullyOcluded = false;
timeOcluded = 0; // MS
timeToOclude = 1; // Seconds
transitionRoom = noone;


transitionTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
	if (!transitionStarted){
		transitionStarted = true;
		global.pauseGameplay = true;
	}
	
	if (transitionStarted && !fullyOcluded){
		transitionAlpha += fadeInPercent * global.deltaTime;
		if (transitionAlpha >= 1){
			transitionAlpha = 1;
			fullyOcluded = true;
			room_goto(transitionRoom);
		}	
	}else if (fullyOcluded && !(timeOcluded >= timeToOclude)){
		timeOcluded += global.deltaTime;
	}else{
		transitionAlpha -= fadeOutPercent * global.deltaTime;
		
		if (transitionAlpha <= 0){
			transitionAlpha = 0;
			time_source_stop(transitionTimeSource);
			global.pauseGameplay = true;
		}	
	}
}, [], -1);

function transition(_room){
	transitionRoom = _room;
	time_source_start(transitionTimeSource);
}

transition(global.roomList[0][2]);