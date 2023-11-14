extends Area2D


var speed: int = 600
var direction: Vector2 = Vector2.DOWN
var fire_distance_limit: int = 1300

@onready var explosionTimer = $explosionTimer
@onready var explosionAnimation = $explosionAnimation
@onready var spriteLazer = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	explosionTimer.wait_time = 0.67


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not explosionTimer.is_stopped():
		return
	position += speed * delta * direction
	if position.y > fire_distance_limit:
		queue_free()

func _on_explosion_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(1)
		spriteLazer.hide()
		explosionAnimation.show()
		explosionAnimation.play()
		explosionTimer.start()
