extends Area2D

const SPEED = 60.0
const DIRECTION = Vector2.UP


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position -= delta * DIRECTION * SPEED
	
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		Globals.player_health_point += 1
		queue_free()
