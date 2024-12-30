extends CharacterBody3D

func _physics_process(delta: float) -> void:
	velocity.y -= 9.81 * delta
	#get_input(delta)
	move_and_slide()
