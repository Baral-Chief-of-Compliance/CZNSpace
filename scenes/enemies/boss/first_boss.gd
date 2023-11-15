extends CharacterBody2D

const LIFE = 10000
const SPEED = 200


var health_point = LIFE


###MOVMENT
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")


###ATTACK
@onready var coolDownAttack = $CoolDownAttack


###LASER
var aim_laser : PackedScene = preload("res://scenes/enemies/boss/aim_line.tscn")
@onready var leftLaserAim = $leftLaserAim
@onready var rightLasetAim = $rightLaserAim
@onready var mainLaserAim = $mainLaserAim
@onready var timerLaserAim = $TimerForLaserAim
@onready var laserShotAnimation = $laserShotAnimation
@onready var timeLaserShoot = $TimeForLaserShoot
var laserArea : PackedScene = preload("res://scenes/enemies/boss/laser_area.tscn")


func _ready():
	coolDownAttack.wait_time = 20.0
	timerLaserAim.wait_time = 4.0
	timeLaserShoot.wait_time = 3.4


func _process(delta):
	var playerVector2 = Vector2(player.global_position.x, position.y)
	var dir_to_player = global_position.direction_to(playerVector2)
	velocity = dir_to_player * SPEED
	fire()
	move_and_slide()
	

func take_damage(damage):
	health_point -= damage
	
func fire():
	#randomize()
	if not coolDownAttack.is_stopped():
		return
		
	
	coolDownAttack.start()
	
	var function_number = randi_range(1,1)
	
	if function_number == 1:
		boss_attack_1()
	elif function_number == 2:
		boss_attack_2()
	elif function_number == 3:
		boss_attack_3()
	elif function_number == 4:
		boss_attack_4()
	
	
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
		
#laser_attack
func boss_attack_2():
	pass
	

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
	
