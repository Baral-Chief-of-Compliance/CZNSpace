extends CharacterBody2D


const SPEED = 70.0
const DIRECTION = Vector2.UP
var health_point : int =  40
var reward_points : int = 5

@onready var smallEnemySprite = $Sprite2D
@onready var explosionAnimation = $ExplosionAnimation
@onready var exlosionTimer = $ExplosionTimer

@onready var smallEnemyCollisionShape = $CollisionShape2D


func _ready():
	exlosionTimer.wait_time = 0.67


func _physics_process(delta):		
	position -= delta * DIRECTION * SPEED
	move_and_slide()
	

func _process(delta):
	if not exlosionTimer.is_stopped():
		return
		
	if health_point <= 0:
		explosionAnimation.play()
		exlosionTimer.start()
		smallEnemyCollisionShape.queue_free()
		smallEnemySprite.hide()
		explosionAnimation.show()
		
		Globals.player_score += reward_points
		
		
func take_damage(damage):
	health_point -= damage
	


func _on_explosion_timer_timeout():
	queue_free()
