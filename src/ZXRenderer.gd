extends ViewportContainer

class_name ZXRenderer

# How many cells wide the screen is
const CHARCELL_WIDTH = 32
# How many cells tall the screen is
const CHARCELL_HEIGHT = 24

enum {BLACK = 0, BLUE = 1, RED = 2, MAGENTA = 3, GREEN = 4, CYAN = 5, YELLOW = 6, WHITE = 7}

export var palette: PoolColorArray = [
	Color(0,0,0), #0 Black
	Color(0,0,1), #1 Blue
	Color(1,0,0), #2 Red
	Color(1,0,1), #3 Magenta
	Color(0,1,0), #4 Green
	Color(0,1,1), #5 Cyan
	Color(1,1,0), #6 Yellow
	Color(1,1,1)  #7 White
	]

var attr_ink: PoolByteArray
var attr_paper: PoolByteArray
export var paper_color: int
export var ink_color: int

func _init():
	attr_ink.resize(CHARCELL_WIDTH * CHARCELL_HEIGHT)
	attr_paper.resize(CHARCELL_WIDTH * CHARCELL_HEIGHT)
	# clear_attributes(paper_color, ink_color)

func clear_attributes(_paper_color: int, _ink_color: int):
	for x in range(CHARCELL_WIDTH):
		for y in range(CHARCELL_HEIGHT):
			var idx: int = y*CHARCELL_WIDTH+x
			attr_ink.set(idx, _ink_color)
			attr_paper.set(idx, _paper_color)

func _ready():
	set_palette(palette)

func set_palette(colors):
	var image = Image.new()
	image.create(colors.size(), 1, false, Image.FORMAT_RGB8)
	image.lock()
	for i in range(colors.size()):
		image.set_pixel(i, 0, colors[i])
	image.unlock()
	var texture = ImageTexture.new()
	texture.create_from_image(image, 0)
	material.set_shader_param("palette", texture)


# Sends an attribute plane to the shader
func _shade_attributes(attribute_plane: String, attributes: PoolByteArray):
	var image = Image.new()
	image.create_from_data(CHARCELL_WIDTH, CHARCELL_HEIGHT, false, Image.FORMAT_R8, attributes)

	var attr_texture = ImageTexture.new()
	attr_texture.create_from_image(image, 0)
	
	material.set_shader_param(attribute_plane, attr_texture)
	

func _process(_delta):
	clear_attributes(paper_color, ink_color)
	var zxprites: Array = get_tree().get_nodes_in_group("zxprites")
	for sprite in zxprites:
		var rect: Array = sprite.cellchar_bounds()
		for x in range(rect[0], rect[2]+1):
			for y in range(rect[1], rect[3]+1):
				var idx: int = y*CHARCELL_WIDTH+x
				attr_paper.set(idx, sprite.paper)
				attr_ink.set(idx, sprite.ink)

	_shade_attributes("paper", attr_paper)
	_shade_attributes("ink", attr_ink)
		
