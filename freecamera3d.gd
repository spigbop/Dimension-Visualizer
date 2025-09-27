class_name FreeCamera3D
extends Camera3D

#region Enums
## Behaviour types when looking around the world with this camera.
enum LOOK_BEHAVIOUR {
	## Looks around only when holding down action_look.
	HOLD,
	## Toggles looking around only after pressing action_look.
	TOGGLE,
	## Always looks around, ignoring action_look.
	ALWAYS
}
#endregion
#region Settings
@export_group("Sensitivity")
## Speed for each axis relative to the [member movement_direction].
@export var speed: Vector3 = Vector3.ONE
@export var look_sensitivity := 0.005

@export_group("Controls", "action")
@export var action_forward: StringName = &"ui_up"
@export var action_backward: StringName = &"ui_down"
@export var action_up: StringName = &"shift"
@export var action_down: StringName = &"ctrl"
@export var action_left: StringName = &"ui_left"
@export var action_right: StringName = &"ui_right"
@export_enum("None", "Left Mouse Button", "Right Mouse Button",
"Middle Mouse Button", "Mouse Wheel Up", "Mouse Wheel Down", "Mouse Wheel Left",
"Mouse Wheel Right", "Mouse XButton 1", "Mouse XButton 2")
var action_look: int = MOUSE_BUTTON_RIGHT
@export var action_look_behaviour: LOOK_BEHAVIOUR = LOOK_BEHAVIOUR.HOLD:
	set(v):
		action_look_behaviour = v
		dragging = v == LOOK_BEHAVIOUR.ALWAYS
#endregion
#region Properties
var movement_direction: Vector3 = Vector3.ZERO

var yaw: float = 0.0
var pitch: float = 0.0
var dragging: bool = false:
	set(v):
		dragging = v
		if current:
			Input.set_mouse_mode(v if Input.MOUSE_MODE_CONFINED_HIDDEN else Input.MOUSE_MODE_VISIBLE)
#endregion
#region Events
func _process(delta: float) -> void:
	if not current:
		return

	movement_direction = Vector3.ZERO

	movement_direction += Input.get_axis(action_forward, action_backward) * transform.basis.z
	movement_direction += Input.get_axis(action_left, action_right) * transform.basis.x

	position += movement_direction * speed * delta


func _input(event: InputEvent) -> void:
	if not current:
		return

	if dragging and event is InputEventMouseMotion:
		yaw -= event.relative.x * look_sensitivity
		pitch -= event.relative.y * look_sensitivity
		pitch = clamp(pitch, -PI/2, PI/2)

		rotation_degrees = Vector3(rad_to_deg(pitch), rad_to_deg(yaw), 0)

	if not event is InputEventMouseButton:
		return

	if action_look_behaviour == LOOK_BEHAVIOUR.ALWAYS:
		return

	if not event.button_index == action_look:
		return

	if action_look_behaviour == LOOK_BEHAVIOUR.HOLD:
		dragging = event.pressed
	elif event.pressed:
		dragging = not dragging
#endregion
