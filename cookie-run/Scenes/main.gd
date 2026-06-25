extends Node3D


var Tree_Scene: PackedScene = preload("res://Scenes/tree.tscn")
var Big_Tree_Scene: PackedScene = preload("res://Scenes/big_tree.tscn")
var Roll_Tree_Scene: PackedScene = preload("res://Scenes/rolling_tree.tscn")

var Ground_Scene: PackedScene = preload("res://Scenes/Ground.tscn")

var Jesus: PackedScene = preload("res://Scenes/jesus.tscn")
var Ball_Scene: PackedScene = preload("res://Scenes/ball.tscn")
var Main_Menu: PackedScene = preload("res://Gameplay_Scenes/main_menu.tscn")
var spawnrange = 3
var Obst
var Rlimit: bool = false

func _ready() -> void:
		Globals.connect("Start_Jesus", _start_Jesus)
		#Globals.connect("Grund", _Grund)
		Globals.Goal = 1000
		Globals.Score = 0
		Globals.Phase = 1
		Globals.Combo = 0
		Globals.Direction = 0
		$DirectionalLight3D.light_color = Color.YELLOW
		$DirectionalLight3D.light_negative = false
		%Sky.modulate = Color.SKY_BLUE
		%Fogbig.modulate = Color(0.459, 1, 1, 0.224)
		$DirectionalLight3D.light_energy = 1

func _process(delta: float) -> void:
	if $Player.rotation.z > 0.01:
		$Player.rotation.z += -0.2 * delta
	if $Player.rotation.z < 0.01:
		$Player.rotation.z += 0.2 * delta
	$AudioStreamPlayer.pitch_scale = 0.95 + (Globals.Combo / 150)
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		var wow = DisplayServer.window_get_size()
		if event.position.x >= wow.x / 2:
			Globals.Direction = 1
			
		if event.position.x < wow.x / 2:
			Globals.Direction = -1
			
	if event is InputEventScreenTouch and not event.pressed:
		Globals.Direction = 0
	pass

func _start_Jesus():
	var Jesiis = Jesus.instantiate() as Area3D
	Jesiis.global_position = Vector3(0,8,-60)
	$"obstacles-list".add_child(Jesiis)

func _on_spawner_make_obst(Markers, Chance) -> void:
	var b = Markers.size() / 2
	for i in b:
		var wow = randi_range(1, Chance)
		if wow == 1:
			Obst = Big_Tree_Scene.instantiate() as Area3D
		if wow == 2:
			Obst = Roll_Tree_Scene.instantiate() as Area3D
		if wow >= 3:
			Obst = Tree_Scene.instantiate() as Area3D
		var Mark = Markers[randi() %  Markers.size()]
		
		var pos = Mark.global_position
		pos.x += randf_range(-spawnrange,spawnrange)
		Markers.erase(Mark)
		
		Obst.Spin_chance = Chance
		Obst.position = pos
		$"obstacles-list".add_child(Obst)

func _on_player_change() -> void:
	get_tree().change_scene_to_packed(Main_Menu)

func _on_pause_timeout() -> void:
	Globals.Pause = false
	if Globals.Phase == 1:
			$DirectionalLight3D.light_color = Color.YELLOW
			$DirectionalLight3D.light_negative = false
			%Sky.modulate = Color.SKY_BLUE
			$DirectionalLight3D.light_energy = 1
			%Fogbig.modulate = Color(0.459, 1, 1, 0.224)
	if Globals.Phase == 2:
			$DirectionalLight3D.light_color = Color.ORANGE
			%Sky.modulate = Color.CHOCOLATE
			%Fogbig.modulate = Color(0.81, 0.6, 0.211, 0.224)
	if Globals.Phase == 3:
			$DirectionalLight3D.light_color = Color.INDIGO
			%Sky.modulate = Color.DARK_BLUE
			%Fogbig.modulate = Color(0.214, 0.187, 0.72, 0.224)
	if Globals.Phase == 4:
			$DirectionalLight3D.light_color = Color.BEIGE
			$DirectionalLight3D.light_negative = true
			$DirectionalLight3D.light_energy = 0.05
			%Fogbig.modulate = Color(0.214, 0.187, 0.72, 0.224)
			%Sky.modulate = Color.BLACK
			
	if Globals.Phase == 5:
			$DirectionalLight3D.light_color = Color.GREEN
			$DirectionalLight3D.light_negative = false
			$DirectionalLight3D.light_energy = 1
			%Sky.modulate = Color.REBECCA_PURPLE
			%Fogbig.modulate = Color(0.914, 0.26, 1, 0.224)

func _on_spawner_pause() -> void:
	%Pause.start(7)
	Globals.Goal += Globals.Goal
	Globals.Phase += 1

func _on_player_camera_tilt(angle: Variant, delta) -> void:
	
	if abs($Player.rotation.z) < 0.09:
		$Player.rotation.z += (-angle * delta) / 2

func _on_jesus_ball_launch(pos, direction) -> void:
	var Ball = Ball_Scene.instantiate() as Area3D
	Ball.position = pos
	Ball.rotation_degrees = direction
	Ball.direction = direction
	$"obstacles-list".add_child(Ball)


func _on_border_body_entered(_body: Node3D) -> void:
	_change()
func _on_border_2_body_entered(_body: Node3D) -> void:
	_change()
func _change():
	get_tree().change_scene_to_file("res://Gameplay_Scenes/coordianteroom.tscn")


#func _Grund() -> void:
	#var Ground = Ground_Scene.instantiate()
	#Ground.position = Vector3(0,0,-810)
	#$"The Ground".add_child(Ground)
