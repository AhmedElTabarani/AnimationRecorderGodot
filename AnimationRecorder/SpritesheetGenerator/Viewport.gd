extends Viewport
 
func _generate_spritesheet(resultFolder, exitAfterFinish):
	
	# Waiting while the viewport texture has rendered
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	
	var spritesheet = get_texture().get_data()
	spritesheet.flip_y()
	spritesheet.convert(Image.FORMAT_RGBA8)
	
	
	print("Size of spritesheet: ", size)
	print("Recording has compeleted")
	spritesheet.save_png(resultFolder + '/'+ "spritesheet.png")
	print("Spritesheet has been stored in ", resultFolder)
	
	if exitAfterFinish:
		get_tree().quit()
