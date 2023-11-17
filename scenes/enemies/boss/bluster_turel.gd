extends Node2D


var blusterScene : PackedScene = preload("res://scenes/enemies/boss/bluster_bullet.tscn")

@onready var blusterRate = $blusterRate
@onready var laswrSpawnPoint = $laserSpawnPoint
@onready var rayCast = $RayCast2D

var player



# Called when the node enters the scene tree for the first time.
func _ready():
	blusterRate.wait_time = 1
	if get_tree().has_group("player"):
		player = get_tree().get_nodes_in_group("player")[0]
		print("find player")
		

func _physics_process(delta):
	_aim()
	_check_player_collision()
	

func _aim():
	rayCast.target_position = to_local(player.position)
	
func _check_player_collision():
	if rayCast.get_collider() == player and blusterRate.is_stopped():
		blusterRate.start()
		
	elif rayCast.get_collider() != player and not blusterRate.is_stopped():
		blusterRate.stop()


func _on_bluster_rate_timeout():
	_shoot()
	
func _shoot():
	var bluster = blusterScene.instantiate()
	bluster.position = position
	bluster.scale.x = 0.2
	bluster.scale.y = 0.2
	bluster.direction = (rayCast.target_position).normalized()
	#bluster.rotation = bluster.position.angle_to_point(rayCast.target_position)
	add_child(bluster)
