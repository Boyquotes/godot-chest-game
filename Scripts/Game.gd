extends Node

# Time score:
static var time_seconds: int = 0
static var time_minutes: int = 0
static var time_hours: int = 0

# Main score:
static var currentStage: int = 1

# Properties:
static var inGame: bool = false
static var hasKey: bool = false
static var hasOpenedChest: bool = false
static var rooms_on_scene: Array = []

static func set_first_room(room: Node2D) -> void:
	rooms_on_scene = []
	rooms_on_scene.append(room)

static func clear_rooms() -> void:
	if rooms_on_scene.size() > 0:
		for room in rooms_on_scene:
			if room != null:
				room.queue_free()

static func clear_score() -> void:
	time_seconds = 0
	time_minutes = 0
	time_hours = 0
	currentStage = 0

static func update_time() -> void:
	time_seconds += 1
	
	if time_seconds >= 60:
		time_seconds = 0
		time_minutes += 1
	
	if time_minutes >= 60:
		time_minutes = 0
		time_hours += 1

static func time_to_string(value: int) -> String:
	if value < 10:
		return "0{0}".format([value])
	else:
		return str(value)

static func get_seconds() -> String:
	return time_to_string(time_seconds)

static func get_minutes() -> String:
	return time_to_string(time_minutes)

static func get_hours() -> String:
	return time_to_string(time_hours)
