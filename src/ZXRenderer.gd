extends ViewportContainer

func _ready():
	var attr_ink = [0,1,2,3,4,5,6,7]
	attr_ink.resize(32*24)
	attr_ink[15][11] = 5;
	var ink_bytes = PoolByteArray(attr_ink)

	var image = Image.new()
	image.create_from_data(32, 24, false, Image.FORMAT_R8, ink_bytes)

	var ink = ImageTexture.new()
	ink.create_from_image(image, 0)
	
	(self.material as ShaderMaterial).set_shader_param("ink", ink)
	
	
	
	
