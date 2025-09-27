class_name NDimPoint
extends Node


const AXIS_NAMES: String = "XYZWVUTSRQPR"


var _dimensions: int = 4
var position: Array[float] = []

var _points3d = []


func _init(dimensions: int, axises: Array[float] = []) -> void:
	if dimensions < 3:
		return

	self._dimensions = dimensions

	for i: int in dimensions:
		position.append(0.0)

	var i: int = 0
	for f: float in axises:
		self.position[i] = f
		i += 1


func _ready() -> void:
	for a: Array in Math.get_combinations(position, 3):
		var node: Node3D = Node3D.new()
		node.position.x = a[0]
		node.position.y = a[1]
		node.position.z = a[2]
		node.name = ",".join(PackedStringArray(a))
		add_child(node)
		_points3d.append(node)

		var mesh: MeshInstance3D = load("res://point.tscn").instantiate()
		node.add_child(mesh)

		NDimWorld.inst().points.append(self)


func set_world(index: int):
	for node: Node3D in _points3d:
		node.visible = false
	if _points3d.size() > index:
		_points3d[index].visible = true
		print("set")


func get_position(camera: CompoundCamera = null) -> Variant:
	if (not camera) or (not camera is CompoundCamera):
		return position

	return
