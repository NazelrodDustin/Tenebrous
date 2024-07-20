/// @description Insert description here
// You can write your code in this editor

// Create an array of room arrays [x, y, room] 
global.roomList = array_create(1, [0, 0, room_duplicate(rm_baseOverworld)]);
global.deltaTime = delta_time / 1000000;
global.pauseOverworld = false;
global.playerOverworld = instance_create_depth(-480, 270, 0, obj_playerOverworld);

// Transitions
fadeInPercent = 0.4;
fadeOutPercent = 0.5;
transitionAlpha = 0.0;
transitionStarted = false;
fullyOcluded = false;
timeOcluded = 0; // MS
timeToOclude = 1; // Seconds
transitionRoom = noone;
firstTransition = false;

transitionTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
	if (!transitionStarted){
		transitionStarted = true;
		global.pauseOverworld = true;
	}
	
	if (transitionStarted && !fullyOcluded){
		transitionAlpha += fadeInPercent * global.deltaTime;
		if (transitionAlpha >= 1){
			transitionAlpha = 1;
			fullyOcluded = true;

		}	
	}else if (fullyOcluded && !(timeOcluded >= timeToOclude)){
		if (timeOcluded <= 0){
			room_goto(transitionRoom);
		}
		
		timeOcluded += global.deltaTime;
	}else{
		
		if (!firstTransition && transitionAlpha >= 1){
			firstTransition = true;

			
			global.playerOverworld.x = room_width / 2 + irandom_range(-room_width / 4, room_width / 4);
			global.playerOverworld.y = room_height / 2 + irandom_range(-room_height / 4, room_height / 4);
			camera_set_view_target(view_camera[0], global.playerOverworld);
		}
		transitionAlpha -= fadeOutPercent * global.deltaTime;
		
		if (transitionAlpha < 0.6){
			global.pauseOverworld = false;	
		}
		
		if (transitionAlpha <= 0){
			transitionAlpha = 0;
			time_source_stop(transitionTimeSource);
		}	
	}
}, [], -1);

function transition(_room){
	transitionRoom = _room;
	transitionAlpha = 0.0;
	transitionStarted = false;
	fullyOcluded = false;
	timeOcluded = 0; // MS
	time_source_start(transitionTimeSource);
}

// Overworld
overworldSurfacePosition = 0;
inBattle = false;

// Battle In
battleAppearTime = 1.5; // Seconds
battleCountUp = 0;

battleInTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
	global.pauseOverworld = true;
	var percent;
	if (battleCountUp < battleAppearTime){
		battleCountUp += global.deltaTime;
		percent = battleCountUp / battleAppearTime;
	}else{
		percent = 1;
		time_source_stop(battleInTimeSource);
	}
	overworldSurfacePosition = animcurve_channel_evaluate(animcurve_get_channel(anc_viewBattleDistort, "In"), percent);
}, [], -1);


function showBattle(){
	time_source_start(battleInTimeSource);
	battleCountUp = 0;
	inBattle = true;
}


// Battle Out
battleDisappearTime = .75; // Seconds
battleCountDown = 0;

battleOutTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
	var percent;
	if (battleCountDown < battleDisappearTime){
		battleCountDown += global.deltaTime;
		percent = battleCountDown / battleDisappearTime;
	}else{
		percent = 1;
		global.pauseOverworld = false;
		inBattle = false;
		time_source_stop(battleOutTimeSource);
	}
	
	overworldSurfacePosition = animcurve_channel_evaluate(animcurve_get_channel(anc_viewBattleDistort, "Out"), percent);
}, [], -1);

function removeBattle(){
	time_source_start(battleOutTimeSource);
	battleCountDown = 0;
	
}

overworldSurface = noone;



// Battle Smear
smearX = 0;
smearY = 0;
surfBattle = noone
smearFrame = 0;
smearSpeed = 15;

transition(global.roomList[0][2]);