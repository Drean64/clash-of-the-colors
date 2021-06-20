extends Sprite

class_name ZXprite, "res://Graphics/ZXprite.svg"

export var paper: int = 0
export var ink: int = 7

func cellchar_bounds() -> Array:
	var rect = get_rect()
	var r2 = [
		int(global_position.x / 8.0),
		int(global_position.y / 8.0),
		0,
		0
		]
	r2[2] = r2[0] + int(rect.size.x) / 8
	r2[3] = r2[1] + int(rect.size.y) / 8
	var g = global_position
	return r2;

