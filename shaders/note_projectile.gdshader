// shader_type canvas_item;

// uniform float line_thickness : hint_range(0, 20) = 1.0;    // thickness of the line
// uniform float sin_frequency : hint_range(0.1, 2.0) = 0.5;  // frequency of the rainbow
// uniform float sin_offset : hint_range(0.0, 360.0) = 0.0;   // offset of the rainbow, useful to differentiate objects using the same shader
// uniform float light_offset : hint_range(0.0, 1.0) = 0.5;   // this offsets all color channels; if set to 0 only red green and blue colors will be shown.

// void fragment() {
// 	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	
// 	float outline = texture(TEXTURE, UV + vec2(-size.x, 0)).a;
// 	outline += texture(TEXTURE, UV + vec2(0, size.y)).a;
// 	outline += texture(TEXTURE, UV + vec2(size.x, 0)).a;
// 	outline += texture(TEXTURE, UV + vec2(0, -size.y)).a;
// 	outline += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
// 	outline += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
// 	outline += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
// 	outline += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
// 	outline = min(outline, 1.0);
	
// 	vec4 animated_line_color = vec4(light_offset + sin(2.0*3.14*sin_frequency*TIME),
// 							   light_offset + sin(2.0*3.14*sin_frequency*TIME + radians(120.0)),
// 							   light_offset + sin(2.0*3.14*sin_frequency*TIME + radians(240.0)),
// 							   1.0);
	
// 	vec4 color = texture(TEXTURE, UV);
// 	COLOR = mix(color, animated_line_color, outline - color.a);
// }

shader_type canvas_item;

uniform vec4 line_color = vec4(1.0);
uniform float line_thickness : hint_range(0, 10) = 1.0;

const vec2 OFFSETS[8] = {
	vec2(-1, -1), vec2(-1, 0), vec2(-1, 1), vec2(0, -1), vec2(0, 1), 
	vec2(1, -1), vec2(1, 0), vec2(1, 1)
};

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	float outline = 0.0;
	
	for (int i = 0; i < OFFSETS.length(); i++) {
		outline += texture(TEXTURE, UV + size * OFFSETS[i]).a;
	}
	outline = min(outline, 1.0);
	
	vec4 color = texture(TEXTURE, UV);
	COLOR = mix(color, line_color, outline - color.a);
}
