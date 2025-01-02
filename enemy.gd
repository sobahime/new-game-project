extends AnimatableBody3D

@onready var projectileObject = preload("res://projectile_1.tscn")

var can_turn: bool = false

func _enter_tree() -> void:
	$"Shoot pause timer".start(0.01)

func _on_turn_pause_timer_timeout() -> void:
	var projectile = projectileObject.instantiate()
	projectile.position = position
	projectile.rotation = rotation
	get_tree().current_scene.add_child(projectile)
	$"Shoot pause timer".start()

func _on_shoot_pause_timer_timeout() -> void:
	can_turn = true
	$"Turn timer".start()
	
func _on_turn_timer_timeout() -> void:
	can_turn = false
	$"Turn pause timer".start()

func _physics_process(delta: float) -> void:
	if can_turn:
		rotate_y(PI/4 * delta)
