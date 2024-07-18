/// @description Insert description here
// You can write your code in this editor

var location = string("Player location: ({0}, {1})", x, y);
draw_text(x - string_width(location) / 2, y - 64, location);
draw_self();