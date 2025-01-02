extends AnimatableBody3D

@onready var projectileObject = preload("res://projectile_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var can_shoot: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if can_shoot:
		var projectile = projectileObject.instantiate()
		add_child(projectile)
		projectile.transform.origin = Vector3(1,0,0)
	pass
