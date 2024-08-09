/// @constructor
/// @func soundEffect(baseName, falloffRef, gain, pitchRandom, volRandom, falloffMax, falloffFactor,  priority)
/// @desc Creates a new sound effect and adds all sounds associated with the base name (baseName1, baseName2, etc..)
/// @param {string} baseName The name for the sound resource minus the number for parsing and adding all the variations
/// @param {real} gain The gain(volume) of the samples
/// @param {real} pitchRandom To what degree the pitch of the samples vary
/// @param {real} volRandom To what degree the volume of the samples vary
/// @param {real} [falloffRef] The distance in which the sound starts falling off 
/// @param {real} [falloffMax] The max distance that the sound can be heard from the listener position        
/// @param {real} [falloffFactor] The number(1 by default) that the falloff model uses to calculation the falloff curve of the sound effect
/// @param {real} [priority] The Priority of the sound
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
	var _maxSampleCheck = 50; //I don't think there will ever be a sound with more than 50 variations????????????
	var _i = 0;
	
	repeat(_maxSampleCheck){
		var _soundIndex = asset_get_index(_baseName + string(_i + 1));
	
		if (_soundIndex != -1){
			if (!audio_exists(_soundIndex)){
				//show_debug_message("Failed to add sound effect variation, soundIndex doesn't exist.");
				break;
			}else{
				array_push(__samples, _soundIndex);		
			}
		}else{
			break;	
		}
		
		_i++;
	}
	
	/// @method play(x, y, global, loop)
	/// @desc Plays the sample at the current RR position
	/// @param {real} x The x position to play the sound at
	/// @param {real} y The y position to play the sound at
	/// @param {bool} global Whether or not the sound should abide by the listener position
	/// @param {bool} loop Whether or not the sound should loop
	static play = function(_x, _y, _global = false, _loop = false){
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
		var _soundEffect = (!_global) ? audio_play_sound_at(_soundToPlay, _x, _y, 0, __falloffRef, __falloffMax, __falloffFactor, _loop, __priority) : audio_play_sound(_soundToPlay, __priority, _loop);
		//audio_sound_gain(_soundEffect ,_volRandomized, 0);
		audio_sound_pitch(_soundEffect, clamp(1 + _pitchRandomAdd, .1, 10));

		//Randomize RR position
		var _oldRR = __rrPosition;
		var _newRR = _oldRR;

		while (_oldRR == _newRR){
			_newRR = irandom(_numberOfSamples - 1);	
		}

		__rrPosition = _newRR;

		return soundEffect;
	}

}



