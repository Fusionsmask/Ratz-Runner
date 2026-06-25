extends Node3D

var pos: Vector3
var Switch: bool = false
var SpawnerRange: float = 2
var Chance

signal pause
signal make_Obst(Markers, Chance)

func _ready() -> void:
	Globals.connect("Phase_End", _Phase_change)
	Globals.connect("Pause_End", _Pause_end)

func _process(_delta: float) -> void:
	var in_range = (abs($Markers/left4.global_position.x - Globals.Player_pos.x) < SpawnerRange) or (abs($Markers/right4.global_position.x - Globals.Player_pos.x) < SpawnerRange)
	if in_range:
		position.x = Globals.Player_pos.x

func _on_spawnrate_timeout() -> void:
	if Switch == true:
		var Markers = $Markers.get_children()
		if Globals.Phase == 1:
			Chance = 30
		if Globals.Phase == 2:
			Chance = 25
		if Globals.Phase == 3:
			Chance = 50
		if Globals.Phase == 4:
			Chance = 20
		if Globals.Phase == 5:
			Chance = 5
		make_Obst.emit(Markers, Chance)

func _Phase_change():
	Switch = false
	pause.emit()

func _Pause_end() -> void:
	Switch = true
	$Timers/Spawnrate.start()
