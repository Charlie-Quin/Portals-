shader_type spatial;

uniform sampler2D texture_albedo : source_color;

void vertex() {
}

void fragment() {
	vec2 base_uv = UV;
	//base_uv = SCREEN_UV;
	vec4 albedo_tex = texture(texture_albedo,base_uv);
	ALBEDO = albedo_tex.rgb;
}
