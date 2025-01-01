extends CharacterBody3D

var max_velocity2D: float = 4
var max_jumps = 2
var remaining_jumps: int = max_jumps
var jump_action_released: bool = true
var jump_strength: float = 4

func can_jump() -> bool:
	return jump_action_released && remaining_jumps > 0

func _physics_process(delta: float) -> void:
	velocity.y -= 9.81 * delta
	
	if is_on_floor():
		remaining_jumps = max_jumps
	
	if Input.is_action_just_released("ui_accept"):
		jump_action_released = true
	
	if can_jump() && Input.is_action_pressed("ui_accept"):
		jump_action_released = false
		remaining_jumps -= 1
		if velocity.y < 0:
			velocity.y = jump_strength
		else:
			velocity.y += jump_strength
	
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var movement_direction = input_vector.normalized()
	
	var velocity2D = max_velocity2D * movement_direction

	velocity.x = velocity2D.x
	velocity.z = velocity2D.y
	
	move_and_slide()
		
