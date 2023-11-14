extends Timer

var TileSpace = preload("res://scenes/space.tscn")

func _ready():
	var space = TileSpace
	var newSpacde = space.instantiate()
	var newSpace2 = space.instantiate()
	newSpace2.position = Vector2(0,-500)
	newSpacde.position = Vector2(0,0)
	add_child(newSpacde)
	add_child(newSpace2)


func _on_timeout():
	var space = TileSpace
	var newSpacde = space.instantiate()
	newSpacde.position = Vector2(0,-1500)
	add_child(newSpacde)
	wait_time = 10
