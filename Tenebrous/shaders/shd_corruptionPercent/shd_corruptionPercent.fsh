//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform sampler2D corruptionMap;

const float xAdd = 960.0 / 40.0;
const float yAdd = 540.0 / 40.0;

void main(){
	float sum = 0.0;

	for (float i = 0.0; i < 1.0; i += 1.0 / xAdd){
		for (float j = 0.0; j < 1.0; j += 1.0 / yAdd){
			sum += texture2D(corruptionMap, vec2(i, j)).r;
		}
	}
	
    gl_FragColor = vec4(vec3(sum / (xAdd * yAdd)), 1.0);
}
