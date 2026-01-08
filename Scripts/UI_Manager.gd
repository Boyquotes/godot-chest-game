extends Control

class_name UI_Manager

# Main UI containers:
var ui_main: Control
var ui_level: Control
var ui_howto: Control
var ui_ingame: Control
var ui_pause: Control
var ui_score: Control

# UI Buttons:
var button_main_play: Button
var button_main_howto: Button
var button_level_return: TextureButton
var button_howto_return: TextureButton
var button_ingame_menu_open: TextureButton
var button_pause_resume: Button
var button_pause_exit: Button
var button_score_retry: Button
var button_score_exit: Button

var label_score_time: Label
var label_score_stage: Label

# Sounds:
var sound_bgm: AudioStreamPlayer2D
var sound_button: AudioStreamPlayer2D
var sound_pause: AudioStreamPlayer2D
var sound_key: AudioStreamPlayer2D
var sound_cross: AudioStreamPlayer2D
var sound_end: AudioStreamPlayer2D

var delta_counter: float = 0.0

func _process(delta: float) -> void:
	# Update game time every second:
	if Game.inGame:
		delta_counter += delta
		if delta_counter >= 1:
			delta_counter = 0
			Game.update_time()
	
	# Update score labels:
	var string_stage = "Stage: {0}".format([Game.currentStage])
	var string_time = "TIme: {0}:{1}:{2}".format([Game.get_hours(), Game.get_minutes(), Game.get_seconds()])
	label_score_stage.text = string_stage
	label_score_time.text = string_time

func _ready() -> void:
	# Get sound players:
	sound_bgm = get_parent().get_parent().get_node("Node2D/AudioListener2D/Bgm")
	sound_button = get_parent().get_parent().get_node("Node2D/AudioListener2D/Button")
	sound_pause = get_parent().get_parent().get_node("Node2D/AudioListener2D/Pause")
	sound_key = get_parent().get_parent().get_node("Node2D/AudioListener2D/Key")
	sound_cross = get_parent().get_parent().get_node("Node2D/AudioListener2D/Cross")
	sound_end = get_parent().get_parent().get_node("Node2D/AudioListener2D/EndGame")
	
	ui_main = get_node("Main title")
	ui_level = get_node("Level selection")
	ui_howto = get_node("How to")
	ui_ingame = get_node("In game hud")
	ui_pause = ui_ingame.get_node("Pause menu")
	ui_score = ui_ingame.get_node("Score")
	
	label_score_time = ui_score.get_node("Label_Time")
	label_score_stage = ui_score.get_node("Label_Stage")
	
	button_main_play = ui_main.get_node("Button_Play")
	button_main_howto = ui_main.get_node("Button_HowTo")
	button_level_return = ui_level.get_node("Button_Return")
	button_howto_return = ui_howto.get_node("Button_Return")
	button_ingame_menu_open = ui_ingame.get_node("Button_OpenMenu")
	button_pause_resume = ui_pause.get_node("Button_Resume")
	button_pause_exit = ui_pause.get_node("Button_Exit")
	button_score_retry = ui_score.get_node("Button_TryAgain")
	button_score_exit = ui_score.get_node("Button_Exit")
	
	button_main_play.pressed.connect(go_to_game)
	button_main_howto.pressed.connect(go_to_tutorial)
	button_level_return.pressed.connect(go_to_main_menu)
	button_howto_return.pressed.connect(go_to_main_menu)
	button_ingame_menu_open.pressed.connect(open_pause_menu)
	button_pause_resume.pressed.connect(close_pause_menu)
	button_pause_exit.pressed.connect(exit_to_menu)
	button_score_retry.pressed.connect(retry_game)
	button_score_exit.pressed.connect(exit_to_menu)
	
	ui_pause.visible = false
	go_to_main_menu()

func go_to_main_menu() -> void:
	sound_button.play(0.0)
	sound_bgm.volume_linear = 1.0
	
	ui_main.visible = true
	ui_level.visible = false
	ui_howto.visible = false
	ui_ingame.visible = false

func go_to_tutorial() -> void:
	sound_button.play(0.0)
	
	ui_main.visible = false
	ui_level.visible = false
	ui_howto.visible = true
	ui_ingame.visible = false

func go_to_game() -> void:
	sound_bgm.play(0.0)
	
	ui_main.visible = false
	ui_level.visible = false
	ui_howto.visible = false
	ui_ingame.visible = true
	ui_pause.visible = false
	ui_score.visible = false
	load_first_room()

func open_pause_menu() -> void:
	sound_bgm.volume_linear = 0.1
	sound_pause.play()
	
	ui_pause.visible = true
	Game.inGame = false
	
func close_pause_menu() -> void:
	sound_bgm.volume_linear = 1.0
	sound_pause.play()
	
	ui_pause.visible = false
	Game.inGame = true

func show_score() -> void:
	sound_end.play()
	sound_bgm.stop()
	
	ui_score.visible = true
	ui_pause.visible = false

func exit_to_menu() -> void:
	sound_button.play()
	sound_bgm.stop()
	
	# Clear rooms from scene.
	Game.clear_rooms()
	Game.clear_score()
	Game.inGame = false
	go_to_main_menu()
	pass

func load_first_room() -> void:
	Game.clear_rooms()
	var room_data = load("res://Scenes/Room.tscn")
	var room = room_data.instantiate()
	room.position = Vector2i(624, 108)
	get_parent().get_parent().get_node("Node2D").add_child(room)
	var game_camera: Camera = get_parent().get_parent().get_node("Camera2D")
	game_camera.currentRoom = room
	
	Game.set_first_room(room)
	Game.inGame = true
	Game.hasOpenedChest = false
	
	sound_bgm.play()

func retry_game() -> void:
	sound_button.play()
	
	Game.clear_rooms()
	Game.clear_score()
	load_first_room()
	go_to_game()
	pass
