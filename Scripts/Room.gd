extends Node2D

class_name Room

var chest_a: Chest
var chest_b: Chest
var room_data: PackedScene
var gameCamera: Camera

func _ready() -> void:	
	# Add this room to main room array:
	Game.rooms_on_scene.append(self)
	
	# Get chest objects:
	chest_a = get_node("Chest_Left")
	chest_b = get_node("Chest_Right")
	
	# Get game camera object:
	gameCamera = get_parent().get_parent().get_node("Camera2D")
	
	# Randomize chests:
	var rng = RandomNumberGenerator.new()
	var res = rng.randi_range(0, 1)
	
	if res == 1:
		chest_a.hasKey = true;
		chest_a.hasKey = false;
	else:
		chest_b.hasKey = true;
		chest_b.hasKey = false;

func load_next_room() -> void:
	# Get room base data to instantiate the next room:
	room_data = load("res://Scenes/Room.tscn")
	
	# Instantiate it:
	var room: Node2D = room_data.instantiate()
	
	# Locate the room on scene:
	room.position.x = 624
	room.position.y = position.y - (144 * 6)
	
	# Append the room to the main 2d node:
	get_parent().add_child(room)
	
	# Update camera target:
	gameCamera.currentRoom = room
