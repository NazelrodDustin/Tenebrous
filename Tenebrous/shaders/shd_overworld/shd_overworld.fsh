//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D corrupt;
uniform sampler2D corruptMap;

void main(){
	
    gl_FragColor = mix(texture2D(gm_BaseTexture, v_vTexcoord), texture2D(corrupt, v_vTexcoord), texture2D(corruptMap, v_vTexcoord).r);
	
}
