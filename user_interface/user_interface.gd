extends CanvasLayer


@onready var countScore = $Control/HBoxContainer/count_score


#HEALTH_POINT
@onready var helathPointRaw = $Control2/health_point_raw
var health_point : PackedScene = preload("res://user_interface/health_point.tscn")

@onready var progressBar = $bossInfo/ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	progressBar.step = 20
	
	for hp in Globals.player_health_point:
		var health_scene = health_point.instantiate()
		helathPointRaw.add_child(health_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	countScore.text =  str(Globals.player_score)
	
	if Globals.player_state == Globals.BOSS_ATTACK:
		#BOSS_INFORMATION
		var bossInfo = $bossInfo
		bossInfo.show()
		var boss : CharacterBody2D = get_tree().get_first_node_in_group("boss")
		
		var bossLabel = $bossInfo/Label
		bossLabel.text = boss.NAME
		
		var bossProgressBar = $bossInfo/ProgressBar
		bossProgressBar.max_value = boss.LIFE
		bossProgressBar.value = boss.health_point
		
	else:
		var bossInfo = $bossInfo
		bossInfo.hide()
		
		
		#print(boss.LIFE)
	
	

	if Globals.player_health_point  > helathPointRaw.get_child_count():
		var health_scene = health_point.instantiate()
		helathPointRaw.add_child(health_scene)
		
	elif Globals.player_health_point < helathPointRaw.get_child_count():
		if Globals.player_health_point < 0:
			return
		else:
			var childrens = helathPointRaw.get_children()
			childrens[0].queue_free()
