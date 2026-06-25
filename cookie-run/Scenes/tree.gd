extends Obstacle



func _ready() -> void:
	var wow = randf_range(0, 255)
	$Sprites/Sprite3D.modulate = Color.from_hsv(wow, 1, 1)
	#$Pillar.modulate = Color.from_hsv(wow, 1, 1)
	

func _process(delta: float) -> void:
	_move(delta)
