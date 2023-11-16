extends Node2D


var laserScene : PackedScene = preload("res://scenes/enemies/enemy_fun_fire.tscn")

@onready var blusterRate = $blusterRate
@onready var laswrSpawnPoint = $laserSpawnPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	blusterRate.wait_time = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not blusterRate.is_stopped():
		return
	blusterRate.start()
	
	var parent = get_parent()
	
	var laser = laserScene.instantiate()
	laser.scale.x = 0.1
	laser.scale.y = 0.1
	laser.speed = 50
	laser.position = laswrSpawnPoint.position
	parent.add_child(laser)
	
