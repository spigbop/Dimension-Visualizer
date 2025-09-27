class_name CompoundCamera
extends Node


var _dimensions: int = 4

#var _cameras2d: Array[Camera2D] = []
var _cameras3d: Array[Camera3D] = []


var active_cam: int = 0:
	set(v):
		_set_active(v)
		active_cam = v


func _set_active(index: int):
	#var pos = _cameras3d[active_cam].position
	#var rot = _cameras3d[active_cam].rotation

	_cameras3d[index].make_current()
	NDimWorld.inst().set_world(index)

	#_cameras3d[index].position = pos
	#_cameras3d[index].rotation = rot


func _input(event: InputEvent) -> void:
	if event.is_released():
		return

	if event.is_action("next_cam"):
		if active_cam == _cameras3d.size() - 1:
			active_cam = 0
		else:
			active_cam += 1
	elif event.is_action("prev_cam"):
		if active_cam == 0:
			active_cam = _cameras3d.size() - 1
		else:
			active_cam -= 1


func _init(dimensions: int = 4) -> void:
	self._dimensions = dimensions


func _ready() -> void:
	for i in Math.n_chooses_p(_dimensions, 3):
		var cam: Camera3D = Camera3D.new()
		cam.projection = Camera3D.PROJECTION_ORTHOGONAL
		cam.size = 5.0
		cam.position.x = 1.75
		cam.position.y = 2.75
		cam.position.z = 1.75
		cam.rotation_degrees = Vector3(-45, 45, 0)
		_cameras3d.append(cam)

		add_child(cam)
		cam.set_script(load("res://freecamera3d.gd"))

	active_cam = 0
	NDimWorld.inst().camera = self
