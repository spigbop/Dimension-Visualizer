class_name NDimWorld
extends Node3D


static var _inst: NDimWorld = null

static func inst() -> NDimWorld:
	return _inst


func _ready() -> void:
	_inst = self
	markers = get_node("markers")
	var point: NDimPoint = NDimPoint.new(4, [0.5, 0.75, 0.25, 1.0])
	add_child(point)
	var cam: CompoundCamera = CompoundCamera.new(4)
	add_child(cam)


static var points: Array[NDimPoint] = []
static var camera: CompoundCamera = null
static var markers: Node3D = null


func set_world(index: int):
	for point: NDimPoint in points:
		point.set_world(index)

	var axises: Array[String] = ["x", "y", "z", "w"]
	var combination = Math.get_combinations(axises, 3)[index]

	var i := markers.get_node("i")
	i.mesh.material = load("res://" + combination[0] + ".tres")
	i.get_node("tip").mesh.material = i.mesh.material
	
	var j := markers.get_node("j")
	j.mesh.material = load("res://" + combination[1] + ".tres")
	j.get_node("tip").mesh.material = j.mesh.material
	
	var k := markers.get_node("k")
	k.mesh.material = load("res://" + combination[2] + ".tres")
	k.get_node("tip").mesh.material = k.mesh.material
