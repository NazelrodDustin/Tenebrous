draw_set_font(fnt_robotomono);



draw_sprite_ext(sprite_index, image_index, x + xOffset, y + yOffset, 1, 1, rotation, c_white, 1);


var drawString = string("Y offset: {0}, Sound Played: {1}", yOffset, soundPlayed ? "True" : "False");
draw_text(x - string_width(drawString) / 2, y - 64, drawString);