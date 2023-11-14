extends CharacterBody2D


var laser_scene : PackedScene = preload("res://scenes/laser.tscn")
@onready var timer_laser = $LaserTimer
@onready var leftGun = $leftGun/Marker2D
@onready var rightGun = $reightGun/Marker2D

###WAR_FORM
@onready var warForm1 = $warForm1
@onready var turbin = $turbin
@onready var warForm2 = $warForm2
@onready var leftGunWar2 = $leftGunWarForm2/Marker2D
@onready var rightGunWar2 = $rightGunWarForm2/Marker2D

###WAR_FORM_3
@onready var warForm3 = $warForm3
@onready var leftGunWar3 = $leftGunWarFrom3
@onready var rightGunWar3 = $rightGunWarForm3
@onready var mainGunWar3 = $mainGunWarForm3


###DEATH_TIMER
@onready var deathTimer = $deathTimer
@onready var deathAnimation = $deathAnimation
@onready var deathMenu = $DeathMenu



const SPEED = 400


#func _physics_process(delta):
	
#	move_and_slide()

func _ready():
	timer_laser.wait_time = 0.2
	deathTimer.wait_time = 0.67


func _process(delta):
	#global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI/2.0
	if not deathTimer.is_stopped():
		return
	position.x = get_global_mouse_position().x
	fire()
	move_and_slide()


func fire():
	if not timer_laser.is_stopped():
		return
	
	timer_laser.start()
	
	if Globals.player_war_forme == 1:
		var laser_left = laser_scene.instantiate() as Area2D
		var laser_right = laser_scene.instantiate() as Area2D
		laser_left.position = leftGun.global_position
		laser_right.position = rightGun.global_position
		var parent = get_parent()
		
		parent.add_child(laser_left)
		parent.add_child(laser_right)
		
	elif Globals.player_war_forme == 2:
		var laser_left = laser_scene.instantiate() as Area2D
		var laser_left_2 = laser_scene.instantiate() as Area2D
		var laser_right = laser_scene.instantiate() as Area2D
		var laser_right_2 = laser_scene.instantiate() as Area2D
		
		
		laser_left.position = leftGun.global_position
		laser_left_2.position = leftGunWar2.global_position
		laser_right.position = rightGun.global_position
		laser_right_2.position = rightGunWar2.global_position
		var parent = get_parent()
		
		parent.add_child(laser_left)
		parent.add_child(laser_left_2)
		parent.add_child(laser_right)
		parent.add_child(laser_right_2)
		
	elif Globals.player_war_forme == 3:
		var laser_left = laser_scene.instantiate() as Area2D
		var laser_left_2 = laser_scene.instantiate() as Area2D
		var laser_left_3 = laser_scene.instantiate() as Area2D
		
		var laser_right = laser_scene.instantiate() as Area2D
		var laser_right_2 = laser_scene.instantiate() as Area2D
		var laser_right_3 = laser_scene.instantiate() as Area2D
		
		var laser_main = laser_scene.instantiate() as Area2D
		
		laser_left.position = leftGun.global_position
		laser_left_2.position = leftGunWar2.global_position
		laser_left_3.position = leftGunWar3.global_position
		
		laser_right.position = rightGun.global_position
		laser_right_2.position = rightGunWar2.global_position
		laser_right_3.position = rightGunWar3.global_position
		
		laser_main.position = mainGunWar3.global_position
		
		var parent = get_parent()
		
		parent.add_child(laser_left)
		parent.add_child(laser_left_2)
		parent.add_child(laser_left_3)
		
		parent.add_child(laser_right)
		parent.add_child(laser_right_2)
		parent.add_child(laser_right_3)
		
		parent.add_child(laser_main)
		
		
		
	
	
func take_damage(damage):
	Globals.player_health_point -= damage
	if Globals.player_war_forme == 2:
		Globals.player_war_forme -= 1
		warForm2.hide()
		warForm1.show()
	elif Globals.player_war_forme == 3:
		Globals.player_war_forme -= 1
		warForm3.hide()
		warForm2.show() 
	
	if Globals.player_health_point <= 0:
		death()
	
func death():
	warForm1.hide()
	turbin.hide()
	deathTimer.start()
	deathAnimation.show()
	deathAnimation.play()
	
	
func _on_death_timer_timeout():
	deathAnimation.hide()
	deathMenu.show()
	
	
func war_form_up():
	if Globals.player_war_forme == 1:
		Globals.player_war_forme += 1
		warForm1.hide()
		warForm2.show()
	elif Globals.player_war_forme == 2:
		Globals.player_war_forme += 1
		warForm2.hide()
		warForm3.show()
	else:
		return
		
	
