
/// @func soundEffect(baseName, falloffRef, gain, pitchRandom, volRandom, falloffMax, falloffFactor,  priority)
/// @desc Creates a new sound effect and adds all sounds associated with the base name (baseName1, baseName2, etc..)
/// @param {string} baseName The name for the sound resource minus the number for parsing and adding all the variations
/// @param {real} gain The gain(volume) of the samples
/// @param {real} pitchRandom To what degree the pitch of the samples vary
/// @param {real} volRandom To what degree the volume of the samples vary
/// @param {real} falloffRef The distance in which the sound starts falling off 
/// @param {real} falloffMax The max distance that the sound can be heard from the listener position        
/// @param {real} falloffFactor The number(1 by default) that the falloff model uses to calculation the falloff curve of the sound effect
/// @param {real} priority The Priority of the sound
function soundEffect(_baseName, _gain, _pitchRandom, _volRandom, _falloffRef = 200, _falloffMax = 600, _falloutFactor = 2, _priority = 100) constructor {
	__falloffRef = _falloffRef;
	__falloffMax = _falloffMax;
	__falloffFactor = _falloutFactor;
	__baseName = _baseName;
	__gain = _gain;
	__pitchRandom = _pitchRandom;
	__volRandom = _volRandom;
	__priority = _priority;

	__samples = [];
	__rrPosition = 0;
	
	//Parse through the sound names and add existing samples
	var _maxSampleCheck = 50; //I don't think there will ever be a sound with more than 50 variations??
	var _i = 0;
	
	repeat(_maxSampleCheck){
		var _soundIndex = asset_get_index(_baseName + string(_i + 1));
	
		if (_soundIndex != -1){
			if (!audio_exists(_soundIndex)){
				show_debug_message("Failed to add sound effect variation, soundIndex doesn't exist.");
				break;
			}else{
				array_push(__samples, _soundIndex);		
			}
		}else{
			break;	
		}
		
		_i++;
	}
	
	static play = function(_x, _y, _loop = false){
		//Attempt to find a variation of the sound that is not playing
		var _numberOfSamples = array_length(__samples);
		var _i = 0;
		var _soundToPlay = __samples[((__rrPosition + 1) <  _numberOfSamples) ? (__rrPosition + 1) : 0];

		repeat(_numberOfSamples){
			if (!audio_is_playing(__samples[_i])){
				_soundToPlay = __samples[_i];
				__rrPosition = _i;
				break;
			}
		}

		//Play the sound 
		
		var _volRandomized = random_range(__gain - __volRandom, __gain);
		var _pitchRandomAdd = random_range(-(__pitchRandom), __pitchRandom);
		var _soundEffect = audio_play_sound_at(_soundToPlay, _x, _y, 0, __falloffRef, __falloffMax, __falloffFactor, _loop, __priority); 
		audio_sound_gain(_soundEffect ,_volRandomized, 0);
		audio_sound_pitch(_soundEffect, clamp(1 + _pitchRandomAdd, .1, 10));

		//Randomize RR position
		var oldRR = rrPosition;
		var newRR = oldRR;

		while (oldRR == newRR){
			newRR = irandom(rrNumber - 1);	
		}

		arrayId[@ 0] = newRR;

		return soundEffect;
	}

}



/// @func sound_effect_play_varied_sample(arrayId, x, y, loop)
/// @desc Plays a variation of a sound effect within a given sound effect array and returns the id of the sound
/// @param arrayId
/// @param x 
/// @param y 
/// @param loop 
function sound_effect_play_varied_sample(arrayId, xx, yy, loop) {
	if (!is_array(arrayId)){
		show_debug_message("Failed to play sound effect variation, array doesn't exist.");
		exit;
	}

	var falloffRef = arrayId[5];
	var falloffMax = arrayId[6];
	var falloffFactor = arrayId[7];
	var pitchRandom = arrayId[2];
	var pitchRandomAdd = random_range(-(pitchRandom), pitchRandom);
	var gainBase = arrayId[1];
	var volRandom = arrayId[3];
	var volRandomized = random_range(gainBase - volRandom, gainBase);
	var rrPosition = arrayId[0];
	var soundToPlay = arrayId[8 + rrPosition];
	var priority = arrayId[4];

	//Attempt to find a variation of the sound that is not playing
	var rrNumber = scr_sound_effect_get_rr_number(arrayId);

	for (i = 8; i < 8 + rrNumber; i++){
		if (!audio_is_playing(arrayId[i])){
			soundToPlay = arrayId[i];
			break;
		}
	}

	//Play the sound 
	var _soundEffect = audio_play_sound_at(soundToPlay, xx, yy, 0, falloffRef, falloffMax, falloffFactor, loop, priority); 
	audio_sound_gain(soundEffect ,volRandomized, 0);
	audio_sound_pitch(soundEffect, adjust_for_gamespeed(clamp(1 + pitchRandomAdd, .1, 10)));

	//Randomize RR position
	var oldRR = rrPosition;
	var newRR = oldRR;

	while (oldRR == newRR){
		newRR = irandom(rrNumber - 1);	
	}

	arrayId[@ 0] = newRR;

	return soundEffect;
}


/// @func sound_effect_play_varied_sample_centered(arrayId, loop)
/// @desc Plays a variation of a sound effect within a given sound effect array at the center position of the center
/// @param arrayId
/// @param loop 

function sound_effect_play_varied_sample_centered() {
	var arrayId = argument[0];
	var loop = argument[1];

	if (!is_array(arrayId)){
		show_debug_message("Failed to play sound effect variation, array doesn't exist.");
		exit;
	}

	var xx = cam.xw2;
	var yy = cam.yh2;

	sound_effect_play_varied_sample(arrayId, xx, yy, loop);
}


/// @func scr_sound_effect_set_falloff_settings(arrayId, falloff_ref, falloff_max, falloff_factor)
/// @desc Sets falloff settings of a given sound effect 
/// @param arrayId
/// @param falloff_ref
/// @param falloff_max
/// @param falloff_factor
function scr_sound_effect_set_falloff_settings() {

	var arrayId = argument[0];
	var falloffRef = argument[1];
	var falloffMax = argument[2];
	var falloffFactor = argument[3];

	if (!is_array(arrayId)){
		//show_debug_message("Failed to set sound effect falloff, array doesn't exist.");
		exit;
	}

	arrayId[@ 5] = falloffRef;
	arrayId[@ 6] = falloffMax;
	arrayId[@ 7] = falloffFactor;
}