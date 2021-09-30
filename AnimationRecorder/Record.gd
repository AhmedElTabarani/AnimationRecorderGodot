extends Control

onready var viewport = get_viewport()

export(float) var fps = 60.0
export(NodePath) var animation_player_path = null
export(String) var animation_name = ""
export(String, DIR) var resultFolder = ""
export(bool) var exitAfterFinish = true

var animation_player : AnimationPlayer
var animations_list = ""

var images = []
var length : float
var rate : float = 0.0
var pos : float = 0.0


func _ready():
	_check_exception_errors()
	
	# Delete background
	viewport.transparent_bg = true
	
	animation_player = get_node(animation_player_path)
	animation_player.current_animation = animation_name
	length = animation_player.current_animation_length

	rate = (1.0 / fps)
	
	print("Recording...")
	print("Start position: ", rect_position)
	print("End position: ", rect_position + rect_size)
	print("Size: ", rect_size)
	print("Animation name: ", animation_name)
	print("Length: ", length, 's')
	print("FPS: ", fps)

func _check_exception_errors():
	assert(animation_player_path != "", "Error: AnimationPlayer Path is Null")
	assert(get_node(animation_player_path) is AnimationPlayer, "Error: Expected an AnimationPlayer Path")
	assert(animation_name != "", "Error: Expected an Animation name")
	assert(animation_name in get_node(animation_player_path).get_animation_list(), "Error: There is no Animation called " + animation_name)

func _process(_delta):
	animation_player.seek(pos, true)
	pos += rate
	_take_image()
	
	# Waiting while the image is taken
	yield(get_tree(), "idle_frame")
	
	if animation_player.current_animation_position == length:
		_take_image() # Capture last frame
		_save_images()
		
		# Stop '_process(delta)' function 
		set_process(false)
	
func _take_image():
	var image = viewport.get_texture().get_data()
	
	image.flip_y()
	image = image.get_rect(self.get_rect())
	image.convert(Image.FORMAT_RGBA8)
	images.push_back(image)

func _save_images():
	
	# BUG !!
	# Delete first frame (it always be an empty image)
	images.pop_front()
	
	print("No. images: ", images.size())
	print("Recording has compeleted")
	
	var dir = Directory.new()
	if dir.dir_exists(resultFolder) != true:
		dir.make_dir(resultFolder)
	
	var id = 0
	var path
	for image in images:
		path = str(id) + ".png"
		image.save_png(resultFolder + '/' + path)
		id += 1
	print("Images are stored in ", resultFolder)
	
	if exitAfterFinish:
		get_tree().quit()
