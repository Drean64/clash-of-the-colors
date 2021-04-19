extends ViewportContainer

func _ready():
	var attr: Array
	attr.resize(32*24)
	for i in range(32*24):
		attr[i] = 4
	var bpa = PoolByteArray(attr)
	var image = Image.new()
	image.create_from_data(32, 24, false, Image.FORMAT_R8, bpa)
	var ink = ImageTexture.new()
	ink.create_from_image(image, Image.FORMAT_R8)
	(self.material as ShaderMaterial).set_shader_param("pete", 99999)
	
	
	
	
