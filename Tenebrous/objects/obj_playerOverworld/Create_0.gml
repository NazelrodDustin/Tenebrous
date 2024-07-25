
moveSpeed = 5;
collisionList = [obj_tree];
image_speed = 0;

xOffset = 0;
yOffset = 0;
rotation = 0;
soundPlayed = false;
moving = false;
movementProgress = 0;

soundFootStep = new soundEffect("snd_footstep", 1, .1, .01);

radius = irandom_range(25, 50);