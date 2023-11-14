extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_game_pressed():
	Globals.player_health_point = 3
	Globals.player_score = 0
	get_tree().change_scene_to_file("res://scenes/level.tscn")
