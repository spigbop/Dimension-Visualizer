class_name NDimWorld
extends Node3D


static var _inst: NDimWorld = null

static func inst() -> NDimWorld:
	return _inst


func _ready() -> void:
	_inst = self
	var point: NDimPoint = NDimPoint.new(4, [0.4, 0.2, 0.5, 0.6])
	add_child(point)
	var cam: CompoundCamera = CompoundCamera.new(4)
	add_child(cam)


static var points: Array[NDimPoint] = []
static var camera: CompoundCamera = null


func set_world(index: int):
	for point: NDimPoint in points:
		point.set_world(index)
