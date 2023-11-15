extends Area2D


const DIRECTION = Vector2.DOWN
const SPEED = 100
#const LIMIT_Y = 

	
func _physics_process(delta):
	if position.y > 300:
		queue_free()
	else:
		position += DIRECTION * SPEED * delta


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(1)
