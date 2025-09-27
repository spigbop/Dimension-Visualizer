extends Camera3D


const SPEED: float = 0.05
const FRICTION: float = 4.0

var move_direction: Vector3 = Vector3.ZERO


func _input(event: InputEvent) -> void:
	if event.is_released():
		return

	var dir: Vector3 = Vector3.ZERO
	dir += Input.get_axis("ui_right", "ui_left") * Vector3.RIGHT
	dir += Input.get_axis("ui_down", "ui_up") * Vector3.UP
	
	if dir.length_squared() > .01:
		move_direction = dir


func _physics_process(delta: float) -> void:
	position += move_direction * SPEED
	move_direction = move_direction.move_toward(Vector3.ZERO, delta * FRICTION)
