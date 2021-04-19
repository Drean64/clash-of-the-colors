shader_type canvas_item;

const vec4 black = vec4(0., 0., 0., 1.);
const vec4 white = vec4(1., 1., 1., 1.);
const vec4 magenta = vec4(1., 0., 1., 1.);
const vec4 cyan = vec4(0., 1., 1., 1.);

uniform uint pete;
uniform isampler2D ink;
uniform isampler2D paper;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	vec2 char = vec2(UV / TEXTURE_PIXEL_SIZE) / 8.;
	if (COLOR == white)  {
		ivec4 col = texture(ink, char);
		if (col.r == 4) {
			COLOR = magenta;
		}
		else {
			COLOR = cyan;
		}
	}
	else {
		COLOR = black;
	}
}