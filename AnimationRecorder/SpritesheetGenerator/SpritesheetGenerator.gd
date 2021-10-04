extends ViewportContainer

onready var Grid = $Viewport/GridContainer

var imageTexture : ImageTexture
var textureRect : TextureRect

var resultFolder
var exitAfterFinish

func _init_data(numberOfColumns, resultFolder, exitAfterFinish):
	Grid.columns = numberOfColumns
	self.resultFolder = resultFolder
	self.exitAfterFinish = exitAfterFinish
	
func _save_image(image):
	imageTexture = ImageTexture.new()
	imageTexture.create_from_image(image)

	textureRect = TextureRect.new()
	textureRect.texture = imageTexture

	Grid.add_child(textureRect)
	
func _generate_spritesheet():
	# Set the size of the sprite sheet
	var width = Grid.rect_size.x
	var hight = Grid.get_children()[0].rect_size.y * (ceil(Grid.get_children().size() / float(Grid.columns)))
	$Viewport.size =  Vector2(width, hight)
	$Viewport._generate_spritesheet(resultFolder, exitAfterFinish)
