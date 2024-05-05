shader_type spatial;

uniform sampler2D _albedo : source_color;

uniform bool useVertex;
uniform bool cut;

uniform mat4 cutplane;
varying vec3 wvtx;

varying vec3 myColor;

void vertex() {
	//world space to local
	wvtx = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
	
	myColor.rgb = VERTEX.rgb;
}

void fragment() {
	
	vec3 planeNormal = normalize(cutplane[1].xyz);
	float planeDistance = dot(planeNormal,cutplane[3].xyz);
	float vertexDistance = dot(planeNormal,wvtx);
	float dist = vertexDistance - planeDistance;
	
	if (dist < 0.0 && cut) discard;
	
	
	if (useVertex){
		ALBEDO = myColor;
	}
	else{
		ALBEDO = texture(_albedo,UV).rgb;
	}
	
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
