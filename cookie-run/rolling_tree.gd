extends Obstacle


func _process(delta: float) -> void:
	speed = 60 + Globals.Combo
	rotation.x += (((speed / 5) + Globals.Combo) / 2) * delta
	_move(delta)
