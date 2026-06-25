extends Area3D
class_name Obstacle

var speed = 50
var combo_strenght = 5
var point: bool = true

var Spin_chance: int


#func _ready() -> void:
	#var wow = randf_range(0, 255)
	##Spin = randi_range(1, Spin_chance)
	##if Spin == 1:
		##rotation_degrees.z = -90
	#$Sprite3D.modulate = Color.from_hsv(wow, 1, 1)

#func _process(delta: float) -> void:
	#
	##movement
	##if Spin == 1:
		##speed = 80
		##rotation.x += (speed + Globals.Combo) * delta
	#_move(delta)

func _move(delta: float):
	
	position.z += (speed + Globals.Combo) * delta
	
	if(position.z >= 0 and point):
		_Update_Score()
		point = false
	if(position.z >= 30):
		queue_free()

func _on_body_entered(body: Node3D) -> void:
	if "hit" in body:
		body.hit()

func _Update_Score():
	var Wombo = ceili((Globals.Combo / combo_strenght) + 1)
	Globals.Score += 1 * Wombo
