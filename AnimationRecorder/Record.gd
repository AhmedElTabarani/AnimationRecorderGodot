tool
extends Control

onready var viewport = get_viewport()
onready var SpritesheetGenerator = preload("res://AnimationRecorder/SpritesheetGenerator/SpritesheetGenerator.tscn")
onready var spritesheetGenerator = SpritesheetGenerator.instance()

export(float) var fps = 60.0
export(NodePath) var animation_player_path = null
export(String) var animation_name = ""
export(String, DIR) var resultFolder = ""

enum SaveAs {SPLIT_IMAGES, SPRITE_SHEET}
export(SaveAs) var saveOption = SaveAs.SPLIT_IMAGES setget _set_save_as

var numberOfColumns = 5
var exitAfterFinish = true

var animation_player : AnimationPlayer

var images = []
var length : float
var rate : float = 0.0
var pos : float = 0.0
var id = -1

func _set_save_as(option):
	saveOption = option
	property_list_changed_notify()

func _get_property_list():
	var properties = []
	
	if saveOption == SaveAs.SPRITE_SHEET:
		properties.append({
			name = "numberOfColumns",
			type = TYPE_INT,
			usage = PROPERTY_USAGE_DEFAULT
		})
		
	properties.append({
		name = "exitAfterFinish",
		type = TYPE_BOOL,
		usage = PROPERTY_USAGE_DEFAULT
	})
	return properties

func _ready():
	
	if not Engine.editor_hint:
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
		
		# Create result folder if it doesn't exist
		var dir = Directory.new()
		if dir.dir_exists(resultFolder) != true:
			dir.make_dir(resultFolder)
		
		# Prevent Godot from importing the output images as resources
		var file = File.new()
		file.open(resultFolder + "/.gdignore", File.WRITE)
		file.close()
		
		add_child(spritesheetGenerator)
		# Pass initial data to Spritesheet Generator
		spritesheetGenerator._init_data(numberOfColumns, resultFolder, exitAfterFinish)
		spritesheetGenerator.visible = false
	
func _check_exception_errors():
	assert(animation_player_path != "", "Error: AnimationPlayer Path is Null")
	assert(get_node(animation_player_path) is AnimationPlayer, "Error: Expected an AnimationPlayer Path")
	assert(animation_name != "", "Error: Expected an Animation name")
	assert(animation_name in get_node(animation_player_path).get_animation_list(), "Error: There is no Animation called " + animation_name)

func _process(_delta):
	
	if not Engine.editor_hint:
		animation_player.seek(pos, true)
		pos += rate
		
		_take_image()
		
		# Waiting while the image is taken
		yield(get_tree(), "idle_frame")
		
		if animation_player.current_animation_position == length:
			_take_image() # Capture last frame
			
			match saveOption:
				SaveAs.SPLIT_IMAGES:
					_record_finished()
					
				SaveAs.SPRITE_SHEET:
					spritesheetGenerator.visible = true
					spritesheetGenerator._generate_spritesheet()
			
			set_process(false)
			return
		
func _take_image():
	
	if id == -1:
		id += 1
		return
	
	var image = viewport.get_texture().get_data()
	image.flip_y()
	image = image.get_rect(self.get_rect())
	image.convert(Image.FORMAT_RGBA8)
	
	match saveOption:
		SaveAs.SPLIT_IMAGES:
			# Save in folder
			_save_image(image)
			
		SaveAs.SPRITE_SHEET:
			# Save in Grid
			spritesheetGenerator._save_image(image)

func _save_image(image):
	var path
	path = str(id) + ".png"
	image.save_png(resultFolder + '/' + path)
	id += 1

func _record_finished():
	print("No. images: ", id)
	print("Recording has compeleted")
	print("Images are stored in ", resultFolder)
	
	if exitAfterFinish:
		get_tree().quit()

