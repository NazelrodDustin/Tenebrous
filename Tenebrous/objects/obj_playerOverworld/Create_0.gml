
moveSpeed = 6;
collisionList = [obj_playerBlock, obj_house, obj_well];
image_speed = 0;

xOffset = 0;
yOffset = 0;
rotation = 0;
footStepPlayed = true;
moving = false;
movementProgress = 0;

soundFootStep = new soundEffect("snd_footstep", 1, .1, .01);
