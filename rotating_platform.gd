extends AnimatableBody3D

func _physics_process(delta: float) -> void:
	rotate_y(0.5 * delta)
