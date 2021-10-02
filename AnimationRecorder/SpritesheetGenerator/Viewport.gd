extends Viewport
 
func _save_spritesheet(resultFolder, exitAfterFinish):
	
	# Waiting while the viewport texture has rendered
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	
	var spritesheet = get_texture().get_data()
	spritesheet.flip_y()
	spritesheet.convert(Image.FORMAT_RGBA8)
	
	var dir = Directory.new()
	if dir.dir_exists(resultFolder) != true:
		dir.make_dir(resultFolder)
	
	spritesheet.save_png(resultFolder + '/'+ "spritesheet.png")
	print("Spritesheet has been stored in ", resultFolder)
	
	if exitAfterFinish:
		get_tree().quit()
