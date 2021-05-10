shader_type canvas_item;

uniform isampler2D ink;

void fragment() {
	COLOR = vec4(0., 0., 0., 1.); // Black
	ivec2 cell = ivec2(UV / TEXTURE_PIXEL_SIZE) / 8; // 8x8 pixel cell coordinate
	int ink_color = texelFetch(ink, cell, 0).r; // Should be [0..7]
	COLOR.r = float(ink_color) / 7.; // Should normalize the red value to [0..1]
	// Line above is a kind of debug to get a hint at what the ink_color value is
}