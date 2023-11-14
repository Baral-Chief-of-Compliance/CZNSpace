extends Node2D


@onready var SpawnerBonusTimer = $Timer
var WarFormBonus : PackedScene = preload("res://scenes/bonus_for_czn_ship/war_form_boster.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	SpawnerBonusTimer.wait_time = 20.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if Globals.player_war_forme == 3:
		return
	else:
		randomize()
		var multiplier = randi() % 21
		var bonusScene = WarFormBonus.instantiate()
		bonusScene.position = Vector2(50 + (100 * multiplier), -20 )
		var parent = get_parent()
		parent.add_child(bonusScene)
