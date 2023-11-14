extends Area2D


var speed: int = 700
var direction: Vector2 = Vector2.UP
var fire_distance_limit: int = 0

@onready var laser_animation =  $explosionAnimation
@onready var explosionTimer = $explosionTimer
@onready var spriteFlyingLaser = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	explosionTimer.wait_time = 0.67


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not explosionTimer.is_stopped():
		return
	position += speed * delta * direction
	if position.y < fire_distance_limit:
		queue_free()


func _on_body_entered(body):
	if body.is_in_group("enemy") or body.is_in_group("boss"):
		body.take_damage(20)
		spriteFlyingLaser.hide()
		laser_animation.show()
		laser_animation.play()
		explosionTimer.start()
		

func _on_explosion_timer_timeout():
	queue_free()
