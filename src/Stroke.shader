shader_type canvas_item;

const vec4 BLACK = vec4(0,0,0,1);
const vec4 EMPTY = vec4(0,0,0,0);

bool shouldStroke(sampler2D texture, vec2 uv, vec2 texPixelSize, vec2 deltaUV) {
	vec4 pixel = texture(texture, uv + deltaUV * texPixelSize);
	return pixel.a > 0.5;
}

void fragment() {
	const vec2 deltas[] = {
		vec2(-1,0),
		vec2(1,0),
		vec2(0,-1),
		vec2(0,1),
		vec2(-2,0),
		vec2(2,0),
		vec2(0,-2),
		vec2(0,2),
		vec2(-2,2),
		vec2(2,-2),
		vec2(2,2),
		vec2(-2,-2) 		
	};
	COLOR = texture(TEXTURE, UV);
	for( int i = 0; i < deltas.length(); ++i ) {
		if( COLOR.a < 0.5 && shouldStroke(TEXTURE, UV, TEXTURE_PIXEL_SIZE, deltas[i]) ) {
			COLOR = BLACK;
			break;
		}
	}
}

