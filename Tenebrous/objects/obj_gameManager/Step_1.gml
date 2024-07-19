/// @description Insert description here
// You can write your code in this editor
global.deltaTime = delta_time / 1000000;


smearX += 67;
smearY += 26;

smearX = smearX % sprite_get_width(spr_smear);

smearY = smearY % sprite_get_height(spr_smear);

smearFrame += smearSpeed * global.deltaTime;
smearFrame = smearFrame % sprite_get_number(spr_smear);