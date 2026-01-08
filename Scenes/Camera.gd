extends Camera2D

class_name Camera

var currentRoom: Node2D
var moveSpeed: float = 10
var smoothness: float = 0.6
var target_x: int = 0
var target_y: int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentRoom != null:
		follow(delta)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_A:
			print("Camera target x position: ", target_x)
			print("Camera target y position: ", target_y)

func follow(delta: float) -> void:
	var target_speed = moveSpeed * smoothness * delta
	target_x = currentRoom.position.x + 336
	target_y = currentRoom.position.y + 432
	var verticalDistance = abs(position.y - target_y)
	
	if position.x > target_x:
		position.x = position.x - target_speed
	elif position.x < target_x:
		position.x = position.x + target_speed
	else:
		position.x = target_x
		
	if position.y > target_y:
		position.y = position.y - target_speed * verticalDistance
	elif position.y < target_y:
		position.y = position.y + target_speed * verticalDistance
	else:
		position.y = target_y
