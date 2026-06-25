extends Area3D

signal BallLaunch

var a = false
var Player_direction
@export var speed: int = 50
@export var active: bool

func _ready() -> void:
	position = Vector3(Globals.Player_pos.x,-20,0)
	Globals.connect("Start_Jesus", _start_Jesus)
	Globals.connect("Stop_Jesus", _stop_Jesus)
	active = false

func _process(delta: float) -> void:
	if active:
		Player_direction = position.direction_to(Globals.Player_pos)
		var too_close = abs(position.z) < 30
		if too_close:
			speed = 5
			position.x -= Player_direction.x * speed * delta
		else:
			position.x += Player_direction.x * speed * delta
		
		position.z += (Globals.Combo / 2) * delta
		position.y = abs(position.z) / 8
		if position.z >= 3:
			queue_free()

func _on_animation_player_animation_finished(_Moving_up) -> void:
	if active:
		$Wait.start(4)
		if a:
			var pos = %Marker3D.global_position
			var direction = pos.direction_to(Globals.Player_pos)
			print(direction)
			BallLaunch.emit(pos,direction)
		a = true

func _start_Jesus():
	$AnimationPlayer.play("Moving up")
	position = Vector3(Globals.Player_pos.x,8,-72)

func _stop_Jesus():
	active = false
	$AnimationPlayer.play("Moving down")

func _on_wait_timeout() -> void:
	if active:
		$AnimationPlayer.play("Charging")
	
func _on_body_entered(_body: Node3D) -> void:
	get_tree().change_scene_to_file("res://Gameplay_Scenes/maproom.tscn")
