extends ViewportContainer

#class_name ZXRenderer

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

func _ready():
	set_palette(palette)
	_init_attributes("ink", 7)
	_init_attributes("paper", 0)

func _init_attributes(attribute_plane, default_color):
	var attributes = PoolByteArray([])
	attributes.resize(32*24)
	for i in range(0, 32*24):
		attributes[i] = default_color
	
	var image = Image.new()
	image.create_from_data(32, 24, false, Image.FORMAT_R8, attributes)

	var attr_texture = ImageTexture.new()
	attr_texture.create_from_image(image, 0)
	
	material.set_shader_param(attribute_plane, attr_texture)

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
