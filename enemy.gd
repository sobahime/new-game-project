extends AnimatableBody3D

@onready var projectileObject = preload("res://projectile_1/node_3d.tscn")

var can_turn: bool = false
var fire_period: float = 0.4 # the firing cooldown, in seconds
var turn_period: float = 0.6 * fire_period # how many seconds the enemy takes to turn
var pause_period: float = (fire_period - turn_period)/2
var rotation_amount: float = 2*PI / 6 # how much the enemy turns between each shot
var rotation_freq: float = rotation_amount/turn_period # how fast the enemy turns (rad/s)
var rotations: Array = [-PI/2, 0, PI/2, PI] # the way the projectiles are spread out

func _on_turn_timer_timeout() -> void:
	can_turn = false
	$"Turn pause timer".start(pause_period)

func _on_turn_pause_timer_timeout() -> void:
	for ang in rotations:
		var projectile = projectileObject.instantiate()
		projectile.position = position
		projectile.rotation = rotation
		projectile.rotate_y(ang)
		get_tree().current_scene.add_child(projectile)
		projectile.position.y += 0.5
		$"Shoot pause timer".start(pause_period)

func _on_shoot_pause_timer_timeout() -> void:
	can_turn = true
	$"Turn timer".start(turn_period)

func _physics_process(delta: float) -> void:
	if can_turn:
		rotate_y(rotation_freq * delta)
