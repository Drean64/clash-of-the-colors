extends Sprite

export var paper: int = 0
export var ink: int = 7

func cellchar_bounds() -> Rect2:
	var rect = get_rect()
	var rectOut: Rect2 = Rect2(
		floor(global_position.x / 8.0),
		floor(global_position.y / 8.0),
		ceil((global_position.x + rect.size.x) / 8.0 ),
		ceil((global_position.y + rect.size.y) / 8.0 )
		)
	return rectOut;

class_name ZXprite, "res://Graphics/ZXprite.svg"
