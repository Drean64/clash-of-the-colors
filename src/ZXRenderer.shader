shader_type canvas_item;

const vec4 white = vec4(1., 1., 1., 1.);
const vec4 black = vec4(0., 0., 0., 1.);

uniform sampler2D ink;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	ivec2 cell = ivec2(UV / TEXTURE_PIXEL_SIZE) / 8;
	float ink_color = texelFetch(ink, cell, 0).r;
	COLOR = black;
	if(color == white) {
		COLOR.r = ink_color * (256. / 8.);
	}
}