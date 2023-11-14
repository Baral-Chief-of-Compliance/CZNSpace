extends Node2D


@onready var SpawnerBonusTimer = $Timer
var HealthPoint : PackedScene = preload("res://scenes/health_point.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	SpawnerBonusTimer.wait_time = 15.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if Globals.player_health_point > 5:
		return
	else:
		randomize()
		var multiplier = randi() % 21
		var healScene = HealthPoint.instantiate()
		healScene.position = Vector2(50 + (100 * multiplier), -20 )
		var parent = get_parent()
		parent.add_child(healScene)
