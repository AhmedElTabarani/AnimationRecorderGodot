extends ViewportContainer

onready var Grid = $Viewport/GridContainer

var imageTexture : ImageTexture
var textureRect : TextureRect

func _create_spritesheet(images, numberOfColumns, resultFolder, exitAfterFinish):
	
	Grid.columns = numberOfColumns
	
	for image in images:
		imageTexture = ImageTexture.new()
		imageTexture.create_from_image(image)

		textureRect = TextureRect.new()
		textureRect.texture = imageTexture

		Grid.add_child(textureRect)
		
	# Waiting while the grid render his children
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	
	# Set the size of the sprite sheet
	$Viewport.size =  Grid.rect_size
	
	$Viewport._save_spritesheet(resultFolder, exitAfterFinish)
