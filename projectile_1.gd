extends AnimatableBody3D


func _physics_process(delta: float) -> void:
	position.x += 10 * delta
