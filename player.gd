extends CharacterBody3D

var max_velocity2D: float = 4
var max_jumps = 2
var remaining_jumps: int = max_jumps
var jump_action_released: bool = true
var jump_strength: float = 4

var mass: float = 50
var ground_friction: float = 700
var max_speed: float = 10
var movement_acceleration = max_speed * (ground_friction / mass)

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
	
	var velocity2D = Vector2(velocity.x, velocity.z)
	var acceleration2D = movement_acceleration * input_vector - (ground_friction / mass) * velocity2D
	
	velocity.x += acceleration2D.x * delta
	velocity.z += acceleration2D.y * delta
	
	move_and_slide()
		
