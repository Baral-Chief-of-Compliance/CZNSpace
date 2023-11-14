extends Line2D


@export var direction_of_rotation = "midle"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction_of_rotation == "left":
		if rotation > 87.75:
			rotation -= 0.01
			
	elif direction_of_rotation == "right":
		if rotation < 182.42:
			rotation += 0.01
