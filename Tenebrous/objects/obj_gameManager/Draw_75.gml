draw_set_alpha(transitionAlpha);
draw_set_color(c_green);
draw_rectangle(-1, -1, browser_width + 1, browser_height + 1, false);
draw_set_color(c_white);
draw_set_alpha(1);

var location = string("Browser Size: ({0}, {1})", browser_width, browser_height);
draw_text(10, 10, location);