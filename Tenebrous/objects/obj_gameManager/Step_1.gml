global.deltaTime = 1/60;//delta_time / 1000000;

if (global.inBattle){
	battleBGSpriteRotation += 10 * global.deltaTime;
	
	if (global.initiative == 0){
		var enemiesSpawed = battleUIPosition >= 412;
		with (obj_enemy){
			if (scale != 1){
				enemiesSpawed = false;	
			}
		}
		
		if (enemiesSpawed){
			if (global.spellSelected && global.spell != 2){
				global.UIFrame = 4;	
			}else{
				global.UIFrame = global.spell + 1;
			}
		}else{
			global.UIFrame = 0;	
		}
	}else{
		global.UIFrame = 5;	
	}
}else{
	global.UIFrame = 0;	
}

if (global.lastBW != browser_width || global.lastBH != browser_height){
	window_set_size(browser_width, browser_height);
	surface_resize(application_surface, browser_width, browser_height);

	view_wport[7] = browser_width;
	view_hport[7] = browser_height;
	
	global.lastBW = browser_width;
	global.lastBH = browser_height;
}


drawArray = array_create(1, [global.playerOverworld, global.playerOverworld.y]);

with (obj_corruptibleParent){
	array_push(other.drawArray, [id, y]);
}

array_sort(drawArray, function(element1, element2){
	return sign(element1[1] - element2[1]);	
});

audio_sound_gain(snd_musicLevelClear, menuMusicVolume * global.musicLevel, 0);
audio_sound_gain(snd_musicOverworldBase, overworldMusicVolume * global.musicLevel, 0);
audio_sound_gain(snd_musicOverworldClean, overworldMusicVolume * (1 - global.cameraPercentCorrupt) * global.musicLevel, 0);
audio_sound_gain(snd_musicOverworldCorrupted, overworldMusicVolume * global.cameraPercentCorrupt * global.musicLevel, 0);
audio_sound_gain(snd_musicBattle, battleMusicVolume * global.musicLevel, 0);
audio_sound_gain(snd_musicAfterDeath, deathMusicVolume * global.musicLevel, 0);


//show_debug_message(string("Menu: {0}\nOverworld: {1}\nBattle: {2}\nDeath: {3}", menuMusicVolume, overworldMusicVolume, battleMusicVolume, deathMusicVolume));