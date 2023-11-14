extends CharacterBody2D


const SPEED = 45.0
const DIRECTION = Vector2.UP
var health_point : int = 60
var reward_points : int = 15

@onready var exlosionTimer = $ExplosionTimer
@onready var explosionAnimation = $AnimatedSprite2D
@onready var shipSprite = $Sprite2D
@onready var collision = $CollisionShape2D


###GUN FIRE

@onready var laserTimer = $LaserTimer
@onready var leftGun =  $leftGun/Marker2D
@onready var rightGun = $rightGun/Marker2D
var laser_scene : PackedScene = preload("res://scenes/enemies/enemy_fun_fire.tscn")


func _ready():
	laserTimer.wait_time = 3.0
	exlosionTimer.wait_time = 0.67


func _physics_process(delta):
	position -= delta * DIRECTION * SPEED
	fire()
	move_and_slide()
	
func _process(delta):
	if not exlosionTimer.is_stopped():
		return
	
	if health_point <= 0:
		collision.queue_free()
		shipSprite.hide()
		exlosionTimer.start()
		explosionAnimation.show()
		explosionAnimation.play()
		Globals.player_score += reward_points
	

func take_damage(damage):
	health_point -= damage


func _on_explosion_timer_timeout():
	queue_free()
	
	
func fire():
	if not laserTimer.is_stopped():
		return
	
	laserTimer.start()
	
	var leftLaser = laser_scene.instantiate() as Area2D
	var rightLaser = laser_scene.instantiate() as Area2D
	leftLaser.position = leftGun.global_position
	rightLaser.position = rightGun.global_position
	
	var parent = get_parent()
	
	parent.add_child(leftLaser)
	parent.add_child(rightLaser)
	
	
