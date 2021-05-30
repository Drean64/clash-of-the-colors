extends ViewportContainer

class_name ZXRenderer

# How many cells wide the screen is
const CELL_WIDTH = 32
# How many cells tall the screen is
const CELL_HEIGHT = 24

export var palette: PoolColorArray = [
	Color(0,0,0), # Black
	Color(0,0,1), # Blue
	Color(1,0,0), # Red
	Color(1,0,1), # Magenta
	Color(0,1,0), # Green
	Color(0,1,1), # Cyan
	Color(1,1,0), # Yellow
	Color(1,1,1)  # White
	]

var attr_ink: PoolByteArray
var attr_paper: PoolByteArray

func _ready():
	set_palette(palette)
	attr_ink = _init_attributes("ink", 4)
	attr_paper = _init_attributes("paper", 3)

func _init_attributes(attribute_plane: String, default_color: int):
	var attributes: PoolByteArray = PoolByteArray([])
	attributes.resize(CELL_WIDTH * CELL_HEIGHT)
	for i in range(0, CELL_WIDTH * CELL_HEIGHT):
		attributes[i] = default_color
	
	var image = Image.new()
	image.create_from_data(CELL_WIDTH, CELL_HEIGHT, false, Image.FORMAT_R8, attributes)

	var attr_texture = ImageTexture.new()
	attr_texture.create_from_image(image, 0)
	
	material.set_shader_param(attribute_plane, attr_texture)
	return attributes

func set_palette(colors):
	var image = Image.new()
	image.create(colors.size(), 1, false, Image.FORMAT_RGB8)
	image.lock()
	for i in range(0, colors.size()):
		image.set_pixel(i, 0, colors[i])
	image.unlock()
	var texture = ImageTexture.new()
	texture.create_from_image(image, 0)
	material.set_shader_param("palette", texture)

func set_attribute(attribute_plane: String, x: int, y: int, color: int):
	var index: int = x + y * CELL_WIDTH
	if attribute_plane == "paper":
		attr_paper.set(index, color)
	else:
		attr_ink.set(index, color)

# Sends an attribute plane to the shader
func _shade_attributes(attribute_plane: String, attributes: PoolByteArray):
	var image = Image.new()
	image.create_from_data(CELL_WIDTH, CELL_HEIGHT, false, Image.FORMAT_R8, attributes)

	var attr_texture = ImageTexture.new()
	attr_texture.create_from_image(image, 0)
	
	material.set_shader_param(attribute_plane, attr_texture)

func _process(_delta):
	_shade_attributes("ink", attr_ink)
	_shade_attributes("paper", attr_paper)
