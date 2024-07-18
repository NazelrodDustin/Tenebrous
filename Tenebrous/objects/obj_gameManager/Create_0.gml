/// @description Insert description here
// You can write your code in this editor


camera_set_begin_script(view_camera[0], function(){
	draw_clear(c_orange);	
});

// Create an array of room arrays [x, y, room] 
global.roomList = array_create(1, [0, 0, rm_baseOverworld]);
global.deltaTime = delta_time / 1000000;
global.pauseOverworld = false;

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
			room_goto(transitionRoom);
			if (!firstTransition){
				firstTransition = true;
				var spawnX = room_width / 2 + irandom_range(- room_width / 4, room_width / 4);
				var spawnY = room_height / 2 + irandom_range(- room_height / 4, room_height / 4);
				
				global.playerOverworld = instance_create_depth(spawnX, spawnY, 0, obj_playerOverworld);
			}
		}	
	}else if (fullyOcluded && !(timeOcluded >= timeToOclude)){
		timeOcluded += global.deltaTime;
	}else{
		transitionAlpha -= fadeOutPercent * global.deltaTime;
		
		if (transitionAlpha <= 0){
			transitionAlpha = 0;
			time_source_stop(transitionTimeSource);
			global.pauseOverworld = true;
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


// Battle In
battleAppearTime = 1.5; // Seconds
battleCountUp = 0;

battleInTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
	global.pauseOverworld = true;
	var percent;
	if (battleCountUp < battleAppearTime){
		battleCountUp += 1 / 60;
		percent = battleCountUp / battleAppearTime;
	}else{
		percent = 1;
		time_source_stop(battleInTimeSource);
	}
	var position = animcurve_channel_evaluate(animcurve_get_channel(anc_viewBattleDistort, "In"), percent);
	view_hport[1] = position;
	view_hport[0] = (540 - position);
	view_yport[0] = position;
	
	camera_set_view_size(view_camera[0], view_wport[0], view_hport[0]);
	camera_set_view_size(view_camera[1], view_wport[1], view_hport[1]);
	show_debug_message(string("H-Port: {0}, Camera Height: {1}", view_hport, camera_get_view_height(view_camera[0])));
	
	
}, [], -1);


function showBattle(){
	time_source_start(battleInTimeSource);
	battleCountUp = 0;
	view_visible[1] = true;
}


battleDisappearTime = .75; // Seconds
battleCountDown = 0;

battleOutTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
	global.pauseOverworld = false;
	var percent;
	if (battleCountDown < battleDisappearTime){
		battleCountDown += 1 / 60;
		percent = battleCountDown / battleDisappearTime;
	}else{
		percent = 1;
		view_visible[1] = false;
		time_source_stop(battleOutTimeSource);
	}
	var position = animcurve_channel_evaluate(animcurve_get_channel(anc_viewBattleDistort, "Out"), percent);
	view_hport[1] = position; 
	view_hport[0] = (540 - position);
	view_yport[0] = position; 
	camera_set_view_size(view_camera[0], view_wport[0], view_hport[0]);
	camera_set_view_size(view_camera[1], view_wport[1], view_hport[1]);
}, [], -1);

function removeBattle(){
	time_source_start(battleOutTimeSource);
	battleCountDown = 0;
}