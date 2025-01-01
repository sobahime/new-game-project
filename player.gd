extends CharacterBody3D

func _physics_process(delta: float) -> void:
	velocity.y -= 9.81 * delta
	
	var max_velocity2D: float = 4
	if !is_on_floor() || Input.is_action_pressed("ui_accept"):
	#ui_accept is used as a jump action		
		max_velocity2D = 2
	
	if is_on_floor() && Input.is_action_pressed("ui_accept"):
		velocity.y = 3
	
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var movement_direction = input_vector.normalized()
	
	var velocity2D = max_velocity2D * movement_direction

	velocity.x = velocity2D.x
	velocity.z = velocity2D.y
	
	move_and_slide()
		
