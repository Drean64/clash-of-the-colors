extends ViewportContainer

func _ready():
	var attr_ink = PoolByteArray([])
	attr_ink.resize(32*24)
	for i in range(0, 32*24):
		attr_ink[i] = i % 8 # fill array with [0..7]
	
	var image = Image.new()
	image.create_from_data(32, 24, false, Image.FORMAT_R8, attr_ink)

	var ink = ImageTexture.new()
	ink.create_from_image(image, 0)
	
	(self.material as ShaderMaterial).set_shader_param("ink", ink)
	
	
	
	
