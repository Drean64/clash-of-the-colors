shader_type canvas_item;

const vec4 BLACK = vec4(0,0,0,1);

bool shouldStroke(sampler2D texture, vec2 uv, vec2 texPixelSize, vec2 deltaUV) {
	vec4 pixel = texture(texture, uv + deltaUV * texPixelSize);
	return pixel.a > 0.5;
}

void fragment() {
	const vec2 strokeSolid[] = {
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
	for( int i = 0; i < strokeSolid.length(); ++i ) {
		if( COLOR.a < 0.5 && shouldStroke(TEXTURE, UV, TEXTURE_PIXEL_SIZE, strokeSolid[i]) ) {
			COLOR = BLACK;
			break;
		}
	}

	const vec2 strokeChecker[] = {
		vec2(-3,0),
		vec2(3,0),
		vec2(0,-3),
		vec2(0,3),
		vec2(-4,0),
		vec2(4,0),
		vec2(0,-4),
		vec2(0,4),
		vec2(-4,4),
		vec2(4,-4),
		vec2(4,4),
		vec2(-4,-4) 		
	};
	for( int i = 0; i < strokeChecker.length(); ++i ) {
		if( COLOR.a < 0.5
			&& (int(FRAGCOORD.x) % 2 == int(FRAGCOORD.y) % 2)
			&& shouldStroke(TEXTURE, UV, TEXTURE_PIXEL_SIZE, strokeChecker[i]) ) {
				COLOR = BLACK;
				break;
		}
	}
}

