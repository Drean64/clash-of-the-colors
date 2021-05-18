shader_type canvas_item;

const int CELL_WIDTH = 32;
const int CELL_HEIGHT = 24;
const int COLOR_COUNT = 12;

uniform sampler2D ink;
uniform sampler2D paper;
uniform sampler2D palette;

void fragment() {
	bool is_ink = texture(TEXTURE, UV).r >= 1.; // quick check for non-black pixel
	ivec2 cell = ivec2(UV / TEXTURE_PIXEL_SIZE) / 8;
	cell.y = CELL_HEIGHT - 1 - cell.y; // invert Y to get top left to be the origin
	
	float color_attr;
	if(is_ink) {
		color_attr = texelFetch(ink, cell, 0).r;
	}
	else {
		color_attr = texelFetch(paper , cell, 0).r;
	}
	COLOR = texture(palette, vec2(color_attr * (256. / float(COLOR_COUNT)), 0.));
}