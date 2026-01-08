extends Area2D

var sprite_main: Sprite2D
var sprite_open: Sprite2D
var tex_open: CompressedTexture2D
var tex_closed: CompressedTexture2D
var room: Node2D
var ui_stage: Label

func _ready() -> void:
	room = get_parent()
	ui_stage = get_parent().get_parent().get_parent().get_node("CanvasLayer").get_node("Game UI").find_child("Label_CurrentStage")
	
	sprite_main = get_node("Sprite_main")
	sprite_open = get_node("Sprite_open")
	tex_open = load("res://Sprites/Door_opened.png")
	tex_closed = load("res://Sprites/Door.png")
	
	sprite_open.visible = false

func open_door() -> void:
	sprite_main.texture = tex_open
	sprite_open.visible = true
	
	Game.hasKey = false
	Game.hasOpenedChest = false
	Game.currentStage += 1
	
	ui_stage.text = "Stage: " + str(Game.currentStage)
	room.load_next_room()

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			if Game.hasKey:
				open_door()
