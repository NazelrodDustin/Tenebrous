/// @description Insert description here
// You can write your code in this editor

if (!shader_is_compiled(shd_corruptionPercent) || !shader_is_compiled(shd_overworld)){
	room_goto(rm_error);	
}

randomize();

global.gameManager = self;
global.lastBW = browser_width;
global.lastBH = browser_height;
global.deltaTime = delta_time / 1000000;

global.seed = random_get_seed();

global.musicLevel = 0.25; // 0-1 to be multiplied with any music tracks being played.
global.sfxLevel = 0.25; // 0-1 to be multiplied with any sfx being played.
global.initiative = 1;
global.difficulty = .75;

global.pauseOverworld = true;
global.inBattle = false;

global.roomsCleared = 0;

global.playerOverworld = instance_create_depth(480, 270, 0, obj_playerOverworld);
global.cameraPercentCorrupt = 0;

global.drawX = -960;
global.drawY = 0;

global.selectedEnemy = -1;
global.spellSelected = false;
global.spell = 0;
global.spellPosition = [0, 0];
global.spellAlpha = 0;

// Colors
global.grassRegularBaseColor = make_color_rgb(70, 130, 50);
global.grassRegularSplashColor = make_color_rgb(37, 86, 46);
global.grassCorruptedBaseColor = make_color_rgb(36, 21, 39);
global.grassCorruptedSplashColor = make_color_rgb(65, 29, 49);


// Overworld
overworldSurfacePosition = 0;
corruptionValues = array_create(15, 0);
corruptionValuesIndex = 0;
global.inBattle = false;
global.UIFrame = 0;

voidPartSystem = part_system_create(ps_void);
part_system_position(voidPartSystem, -980 / 2, 540 * 7 + (540 / 2));
part_system_automatic_draw(voidPartSystem, false);


// Battle In
battleAppearTime = 1.5; // Seconds
battleCountUp = 0;
battleUIPosition = 284;
battleUIAlpha = 0;
battleOffset = 0;

battleInTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
	global.pauseOverworld = true;
	var percent;
	if (battleCountUp < battleAppearTime){
		battleCountUp += global.deltaTime;
		percent = battleCountUp / battleAppearTime;
	}else{
		battleUIAlpha = 1;
		percent = 1;
		battlePartSurfaceOffset += max(battlePartSurfaceOffset * .125, 1);
		battleBGSpriteScale = battlePartSurfaceOffset / 1024;
		
		if (battlePartSurfaceOffset > 1024){
			battleBGSpriteScale = 1;
			for (var i = 0; i < battlePosition; i++){
				var enemy = instance_create_layer(0, 0, "Instances", obj_enemy);
				enemy.inTime = -((i + 1) * 1000);
				enemy.position = battlePositions[battlePosition - 1][i];
				enemy.initiative = i + 1;
			}
			audio_stop_sound(snd_musicOverworldBase);
			audio_stop_sound(snd_musicOverworldClean);
			audio_stop_sound(snd_musicOverworldCorrupted);
			time_source_stop(battleInTimeSource);
		}
	}
	
	battleMusicVolume = percent;
	overworldMusicVolume = 1 - percent;
	
	battleOffset = animcurve_channel_evaluate(animcurve_get_channel(anc_viewBattleDistort, "UI Canvas Offset"), battleBGSpriteScale);
	battleUIPosition = animcurve_channel_evaluate(animcurve_get_channel(anc_viewBattleDistort, "UI"), battleBGSpriteScale);
	overworldSurfacePosition = animcurve_channel_evaluate(animcurve_get_channel(anc_viewBattleDistort, "In"), percent);

}, [], -1);


function showBattle(_battlePosition = 1){
	global.initiative = 0;
	global.selectedEnemy = -1;
	global.spellSelected = false;
	global.spell = 0;
	battlePosition = _battlePosition;
	time_source_start(battleInTimeSource);
	battleCountUp = 0;
	battlePartSurfaceOffset = 0;
	battleBGSpriteRotation = random_range(-84305, 84305);
	battleBGSpriteScale = 0;
	global.inBattle = true;
	audio_play_sound(snd_musicBattle, 1, true);
}


// Battle Out
battleDisappearTime = .75; // Seconds
battleCountDown = 0;

battleOutTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
	var percent;
	
	if (battleCountDown < battleDisappearTime){
		battleBGSpriteScale = max(0, battleBGSpriteScale - (global.deltaTime) * 2.5);
		battleCountDown += global.deltaTime;
		percent = battleCountDown / battleDisappearTime;
	}else{
		percent = 1;
		global.pauseOverworld = false;
		global.inBattle = false;
		
		audio_stop_sound(snd_musicBattle);
		with (obj_enemy){
			instance_destroy();	
		}
		time_source_stop(battleOutTimeSource);
	}
	
	battleMusicVolume = 1 - percent;
	overworldMusicVolume = percent;
	
	if (battleBGSpriteScale <= 0){
		battleUIAlpha = 0;
	}
	battleOffset = animcurve_channel_evaluate(animcurve_get_channel(anc_viewBattleDistort, "UI Canvas Offset"), battleBGSpriteScale);
	battleUIPosition = animcurve_channel_evaluate(animcurve_get_channel(anc_viewBattleDistort, "UI"), battleBGSpriteScale);
	overworldSurfacePosition = animcurve_channel_evaluate(animcurve_get_channel(anc_viewBattleDistort, "Out"), percent);
}, [], -1);

function removeBattle(){

	time_source_start(battleOutTimeSource);
	
	audio_play_sound(snd_musicOverworldBase, 1, true);
	audio_play_sound(snd_musicOverworldClean, 2, true);
	audio_sound_loop_end(snd_musicOverworldClean, audio_sound_length(snd_musicOverworldBase));
	audio_play_sound(snd_musicOverworldCorrupted, 2, true);
	audio_sound_loop_end(snd_musicOverworldCorrupted, audio_sound_length(snd_musicOverworldBase));
	
	
	battleCountDown = 0;
}

mixSurface = noone;
normalSurface = noone;
corruptSurface = noone;
overworldSurface = noone;
deathSurface = noone;


surfaceCorruptPercent = noone;
bufferCorruptPercent = buffer_create(4, buffer_fixed, 1);

drawArray = noone;




// Battle setup
battleSurface = noone;
battlePartSystem = part_system_create(ps_smear);
battleVoidPartSystem = part_system_create(ps_void);
battlePartSurface = noone;
battlePartSurfaceOffset = 0;
battleBGSpriteScale = 0;
battleBGSpriteRotation = random_range(-84305, 84305);
battleBG = global.grassCorruptedBaseColor;
battleVoid = global.grassCorruptedSplashColor;
battlePortalC0 = make_color_rgb(30, 29, 57);
battlePortalC1 = make_color_rgb(117, 36, 56);
battlePortalC2 = make_color_rgb(57, 74, 80);
battlePortalC3 = make_color_rgb(129, 151, 150);
battlePositions = array_create(5);
battlePositions[0] = [[0, 0]];
battlePositions[1] = [[96, 0], [-96, 0]];
battlePositions[2] = [[96, -96], [-96, -96], [0, 96]];
battlePositions[3] = [[192, 96], [96, -96], [-96, -96], [-192, 96]];
battlePositions[4] = [[192, 96], [96, -96], [-96, -96], [-192, 96], [0, 64]];
battlePosition = 0;

part_system_automatic_draw(battlePartSystem, false);
part_system_automatic_draw(battleVoidPartSystem, false);
part_system_position(battleVoidPartSystem, -960 / 2, 540 * 4 + (540 / 2));


#region Transitions
fadeInPercent = 0.4;
fadeOutPercent = 0.5;
transitionAlpha = 0.0;
transitionStarted = false;
fullyOcluded = false;
timeOcluded = 0; // MS
timeToOclude = 1; // Seconds
transitionCallback = function(){};

// DEBUG 
//fadeInPercent = 10000;// 0.4;
//fadeOutPercent = 10000;//0.5;
//timeToOclude = 0.1;//1; // Seconds

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
			transitionCallback();
		}
		
		timeOcluded += global.deltaTime;
	}else{
		transitionAlpha -= fadeOutPercent * global.deltaTime;
		
		if (transitionAlpha < 0.6){
			global.pauseOverworld = false;	
		}
		
		if (transitionAlpha <= 0){
			transitionAlpha = 0;
			time_source_stop(transitionTimeSource);
			transitionCallback = function(){};
		}	
	}
}, [], -1);

function transition(_callback){
	transitionCallback = _callback;
	transitionAlpha = 0.0;
	transitionStarted = false;
	fullyOcluded = false;
	timeOcluded = 0; // MS
	time_source_start(transitionTimeSource);
}
#endregion


corruptionValueTimesource = time_source_create(time_source_global, 5, time_source_units_frames, function(){
	if (!global.pauseOverworld){
		if (!buffer_exists(bufferCorruptPercent)){
			bufferCorruptPercent = buffer_create(4, buffer_fixed, 1);	
		}
	
		if (surface_exists(surfaceCorruptPercent) && buffer_exists(bufferCorruptPercent)){
			buffer_get_surface(bufferCorruptPercent, surfaceCorruptPercent, 0);
			buffer_seek(bufferCorruptPercent, buffer_seek_start, 0);
		
			corruptionValues[corruptionValuesIndex] = buffer_read(bufferCorruptPercent, buffer_u8) / 255;
		}
		corruptionValuesIndex++;
		corruptionValuesIndex = corruptionValuesIndex % array_length(corruptionValues);
		global.cameraPercentCorrupt = averageArray(corruptionValues);
	}
}, [], -1);

time_source_start(corruptionValueTimesource);


function reset(){
	battleUIPosition = 284;
	battleUIAlpha = 0;
	battleOffset = 0;
	
	audio_stop_all();
	
	if (surface_exists(overworldSurface)){
		surface_free(overworldSurface);
	}
	
	with (obj_corruptibleParent){
		instance_destroy();	
	}

	with (obj_playerOverworld){
		instance_destroy();	
	}
	randomize();
	global.seed = random_get_seed();
	
	global.playerOverworld = instance_create_depth(480, 270, 0, obj_playerOverworld);
	global.pauseOverworld = true;
	global.inBattle = false;

	global.roomsCleared = 0;
	global.difficulty = .75;
	
	audio_play_sound(snd_musicLevelClear, 0, true);
}

reset();

//All music levels are 0 - 1;
menuMusicVolume = 1;
overworldMusicVolume = 0; 
battleMusicVolume = 0;
deathMusicVolume = 0;


fadeMenuMusicTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
	if (menuMusicVolume == 1){
		overworldMusicVolume = 0; 
		audio_play_sound(snd_musicOverworldBase, 1, true);
		audio_play_sound(snd_musicOverworldClean, 2, true);
		audio_sound_loop_end(snd_musicOverworldClean, audio_sound_length(snd_musicOverworldBase));
		audio_play_sound(snd_musicOverworldCorrupted, 2, true);
		audio_sound_loop_end(snd_musicOverworldCorrupted, audio_sound_length(snd_musicOverworldBase));
	}
	menuMusicVolume -= 0.0075;
	
	if (menuMusicVolume <= 0){
		menuMusicVolume = 0;
		overworldMusicVolume += 0.0075;
	}
	
	if (overworldMusicVolume >= 1){
		overworldMusicVolume = 1;
		time_source_stop(fadeMenuMusicTimeSource);	
	}
	
	
}, [], -1);

function fadeMenuMusic(){

	time_source_start(fadeMenuMusicTimeSource);
}

deathTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function(){
	menuMusicVolume -= 0.005;
	overworldMusicVolume -= 0.005; 
	battleMusicVolume -= 0.005;
	
	if (menuMusicVolume <= 0){
		menuMusicVolume = 0;
	}
	
	if (overworldMusicVolume <= 0){
		overworldMusicVolume = 0;	
	}
	
	if (battleMusicVolume <= 0){
		battleMusicVolume = 0;	
	}
	
	if (timeStartedPlaying == -1 && menuMusicVolume == 0 && overworldMusicVolume == 0 && battleMusicVolume == 0 && deathMusicVolume == 0){
		timeStartedPlaying = current_time;
		audio_play_sound(snd_musicAfterDeath, 1, false);
	}
	
	if (current_time - timeStartedPlaying < 67000 && timeStartedPlaying != -1){
	
		if (menuMusicVolume == 0 && overworldMusicVolume == 0 && battleMusicVolume == 0 && deathMusicVolume <= 1){
			deathMusicVolume += 0.005;
		}
	
		if (deathMusicVolume >= 1){
			deathMusicVolume = 1;
		}
	}else{
		deathMusicVolume -= 0.1;
		if (deathMusicVolume <= 0){
			deathMusicVolume = 0;
			if (timeStartedPlaying != -1){
				
				transition(function(){
					room_goto(rm_startMenu);
				});
				time_source_stop(deathTimeSource);
			}
		}
		

	}
	
	
}, [], -1);

timeStartedPlaying = -1;

function doDeathScene(){
	timeStartedPlaying = -1;
	deathMusicVolume = 0;
	time_source_start(deathTimeSource);
}



global.charge = new soundEffect("snd_spellChargeUp", global.sfxLevel, .1, .01); 
global.release = new soundEffect("snd_spellRelease", global.sfxLevel, .1, .01); 
global.block = new soundEffect("snd_block", global.sfxLevel, .1, .01); 
global.confusion = new soundEffect("snd_confusionSpellHit", global.sfxLevel, .1, .01);
global.damage = new soundEffect("snd_confusionSpellCast", global.sfxLevel, .1, .01);
