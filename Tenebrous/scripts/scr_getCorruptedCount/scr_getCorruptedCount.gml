function getCorruptedCount(){

	var count = 0;
	
	with (obj_corruptibleParent){
		if (corrupted){
			count++;	
		}
	}
	
	return count;
}