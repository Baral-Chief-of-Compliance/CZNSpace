extends Node2D

var small_enemy : PackedScene = preload("res://scenes/enemies/small_enemy.tscn")
var mid_enemy : PackedScene = preload("res://scenes/enemies/mid_enemy.tscn")
#var big_enemy : PackedScene = preload("res://scenes/enemies/big_enemy.tscn")
var empty_enemy : PackedScene = preload("res://scenes/enemies/empty_enemy.tscn")

const ENEMY_IN_ROW = 20

@onready var spawnerTimer = $SpawnerTimer

var enemies_varinats  = [small_enemy, mid_enemy, empty_enemy]


# Called when the node enters the scene tree for the first time.
func _ready():
	spawnerTimer.wait_time = 10.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_spawner_timer_timeout():
	if Globals.player_state == Globals.MOBS_ATTACK:
		for enemy in ENEMY_IN_ROW:
			randomize()
			var enemy_kind = enemies_varinats[randi() % 3]
			var enemy_scene = enemy_kind.instantiate()
			enemy_scene.position = Vector2(50 + (100 * enemy), -20 )
			var parent = get_parent()
			parent.add_child(enemy_scene)
	else:
		return
