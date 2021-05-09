shader_type canvas_item;

const vec4 black = vec4(0., 0., 0., 1.);
const vec4 white = vec4(1., 1., 1., 1.);
const vec4 magenta = vec4(1., 0., 1., 1.);
const vec4 cyan = vec4(0., 1., 1., 1.);

uniform isampler2D ink;
uniform isampler2D paper;

void fragment() {
	COLOR = black;
	vec4 color = texture(TEXTURE, UV);
	ivec2 char = ivec2(UV / TEXTURE_PIXEL_SIZE) / 8;
	int ink_color = texelFetch(ink, char, 0).r;
	if( color == white ) {
		COLOR = white;
		if(ink_color == 0) {
			COLOR = cyan;
		}
		else {
			COLOR.r = float(ink_color) / 8.;
		}
	}
}