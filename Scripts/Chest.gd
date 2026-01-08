extends Area2D

class_name Chest

var hasKey: bool = true
var anim: AnimationPlayer
var key: Area2D
var cross: Sprite2D

var ui_manager: UI_Manager

func _ready() -> void:
	ui_manager = get_parent().get_parent().get_parent().get_node("CanvasLayer").get_node("Game UI")
	
	anim = get_node("AnimationPlayer")
	key = get_node("Key")
	cross = get_node("Cross")
	key.visible = false
	cross.visible = false

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			open()

func open() -> void:
	if !Game.hasOpenedChest:
		if hasKey:
			anim.play("anim_chest_open")
		else:
			anim.play("anim_chest_open_failure")
		Game.hasOpenedChest = true

func spawnKey() -> void:
	key.visible = true
	ui_manager.sound_key.play()

func spawnCross() -> void:
	cross.visible = true
	ui_manager.sound_cross.play()

func endGame() -> void:
	ui_manager.show_score()
	Game.inGame = false
