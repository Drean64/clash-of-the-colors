shader_type canvas_item;

const vec4 white = vec4(1., 1., 1., 1.);
const vec4 black = vec4(0., 0., 0., 1.);

uniform sampler2D ink;
uniform sampler2D paper;
uniform sampler2D palette;

void fragment() {
	// bool is_ink = texture(TEXTURE, UV).r >= 1.; // quick check for non-black pixel
	vec4 color = texture(TEXTURE, UV);
	ivec2 cell = ivec2(UV / TEXTURE_PIXEL_SIZE) / 8;
	float color_attr = texelFetch(ink, cell, 0).r;
	COLOR = black;
	// if(is_ink) 
	if(color == white) {
		COLOR.r = ink_color * (256. / 8.);
	}
}