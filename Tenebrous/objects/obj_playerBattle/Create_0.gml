/// @description Insert description here
// You can write your code in this editor

//show_debug_message(id);


function doBlock(){
	var text = instance_create_layer(x, y - 48, "Instances", obj_textFade);
	text.text = "Blocked";
}