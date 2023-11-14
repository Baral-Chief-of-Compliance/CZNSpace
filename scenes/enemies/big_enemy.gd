extends CharacterBody2D


const SPEED = 20.0
const DIRECTION = Vector2.UP
var health_point : int = 80
var reward_points : int = 30

@onready var explosionTimer = $explosionTimer
@onready var explosionAnimation = $explosionAnimation
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D


func _ready():
	explosionTimer.wait_time = 0.67


func _physics_process(delta):
	position -= delta * DIRECTION * SPEED
	move_and_slide()
	

func _process(delta):
	if not explosionTimer.is_stopped():
		return
	
	if health_point <= 0:
		collision.queue_free()
		sprite.hide()
		explosionTimer.start()
		explosionAnimation.show()
		explosionAnimation.play()
		Globals.player_score += reward_points
		
	

func take_damage(damage):
	health_point -= damage


func _on_explosion_timer_timeout():
	queue_free()
