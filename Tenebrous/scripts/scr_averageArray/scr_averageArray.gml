// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function averageArray(array){
	var length = array_length(array);
	if (length > 1){
		var sum = 0;
	
		for (var i = 0; i < length; i++){
			sum += array[i];	
		}
	
		return sum / length;
	}else{
		return length;	
	}
}