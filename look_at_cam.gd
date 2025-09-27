extends MeshInstance3D


func _process(delta: float) -> void:
	var cam: Camera3D = get_viewport().get_camera_3d()
	look_at(cam.global_position, Vector3.UP)
