extends CharacterBody2D

const LIFE = 10000
const SPEED = 200
const NAME = "Слуга Безработицы"


var health_point = LIFE


###MOVMENT
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")


###ATTACK
@onready var coolDownAttack = $CoolDownAttack


###LASER (attack_1)
var aim_laser : PackedScene = preload("res://scenes/enemies/boss/aim_line.tscn")
@onready var leftLaserAim = $leftLaserAim
@onready var rightLasetAim = $rightLaserAim
@onready var mainLaserAim = $mainLaserAim
@onready var timerLaserAim = $TimerForLaserAim
@onready var laserShotAnimation = $laserShotAnimation
@onready var timeLaserShoot = $TimeForLaserShoot
var laserArea : PackedScene = preload("res://scenes/enemies/boss/laser_area.tscn")


###BLUSTER (attack_2)
@onready var frontLeftFirstSpawn = $blusters/front/left/first/spawnPoint
@onready var frontLeftSecondSpawn = $blusters/front/left/second/spawnPoint

@onready var frontRightFirstSpawn = $blusters/front/right/first/spawnPoint
@onready var frontRightSecondSpawn = $blusters/front/right/second/spawnPoint

@onready var backLeftFirstSpawn = $blusters/back/left/first/spawnPoint
@onready var backLeftSecondSpawn = $blusters/back/left/second/spawnPoint

@onready var backRightFirstSpawn = $blusters/back/right/first/spawnPoint
@onready var backRightSecondSpawn = $blusters/back/right/second/spawnPoint

var turelScene : PackedScene = preload("res://scenes/enemies/boss/bluster_turel.tscn")

@onready var blusterSpawnPoints = [
	frontLeftFirstSpawn,
	frontLeftSecondSpawn,
	frontRightFirstSpawn,
	frontRightSecondSpawn,
	backLeftFirstSpawn,
	backLeftSecondSpawn,
	backRightFirstSpawn,
	backRightSecondSpawn
]

@onready var blusterTimer = $blusterTimer

@onready var blusterRate = $blusterRate


###DEATH
@onready var deathTimer = $deathTimer


func _ready():
	coolDownAttack.wait_time = 20.0
	timerLaserAim.wait_time = 4.0
	timeLaserShoot.wait_time = 3.4
	deathTimer.wait_time = 0.67
	blusterTimer.wait_time = 5.0
	blusterRate.wait_time = 0.3


func _process(delta):
	
	if not deathTimer.is_stopped():
		return
	
	var playerVector2 = Vector2(player.global_position.x, position.y)
	var dir_to_player = global_position.direction_to(playerVector2)
	velocity = dir_to_player * SPEED
	fire()
	move_and_slide()
	

func take_damage(damage):
	health_point -= damage
	if health_point <= 0:
		death()
	
func fire():
	#randomize()
	if not deathTimer.is_stopped():
		return
	
	if not coolDownAttack.is_stopped():
		return
		
	
	coolDownAttack.start()
	
	var function_number = randi_range(1,2)
	
	if function_number == 1:
		boss_attack_1()
	elif function_number == 2:
		boss_attack_2()
	elif function_number == 3:
		boss_attack_3()
	elif function_number == 4:
		boss_attack_4()
	
#laser_attack
func boss_attack_1():
	if not timerLaserAim.is_stopped():
		return
	
	timerLaserAim.start()
	var laserAim1 = aim_laser.instantiate()
	#var laserAim2 = aim_laser.instantiate()
	var laserAim3 = aim_laser.instantiate()
	
	laserAim1.position = leftLaserAim.position
	#laserAim2.position = mainLaserAim.position
	laserAim3.position = rightLasetAim.position
	
	laserAim1.direction_of_rotation = "left"
	laserAim3.direction_of_rotation = "right"
	
	laserAim1.rotation = 90
	laserAim3.rotation = 180.2
	
	var lasers_enviroment = $lasers
	
	
	lasers_enviroment.add_child(laserAim1)
	#add_child(laserAim2)
	lasers_enviroment.add_child(laserAim3)
		
#bluster_attack
func boss_attack_2():
	var parent = get_parent()
	
	for turel_point in blusterSpawnPoints:
		var turel = turelScene.instantiate()
		turel.scale.y = 0.2
		turel.scale.x = 0.2
		turel.position = turel_point.position
		add_child(turel)
		print("turel is created")

	

func boss_attack_3():
	pass
	
	
func boss_attack_4():
	pass


func _on_timer_for_laser_aim_timeout():
	timeLaserShoot.start()
	laserShotAnimation.show()
	laserShotAnimation.play()
	var laserAreaInst = laserArea.instantiate() as Area2D
	laserAreaInst.position = mainLaserAim.position
	add_child(laserAreaInst)
	
	var lasers_enviroment = $lasers
	var childrens = lasers_enviroment.get_children()
	
	for ch in childrens:
		ch.queue_free()



func _on_time_for_laser_shoot_timeout():
	laserShotAnimation.hide()
	laserShotAnimation.stop()
	
	
func death():
	var bossColission = $CollisionPolygon2D
	bossColission.queue_free()
	
	var deathAnimation = $DeathAnimation
	var sprite = $Sprite2D
	var turbin = $turbin
	
	
	sprite.hide()
	turbin.hide()
	deathTimer.start()
	deathAnimation.show()
	deathAnimation.play()
	


func _on_death_timer_timeout():
	Globals.player_state = Globals.MOBS_ATTACK
	Globals.player_score += 1000
	queue_free()
