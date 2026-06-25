extends Node3D

var allow: bool = false

func _process(delta: float) -> void:
	if allow:
		$Control.visible = true

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		var eventpos = DisplayServer.window_get_size()
		var BackSpot = event.position.x >= ((eventpos.x / 10) * 8.2) and event.position.x <= ((eventpos.x / 10) * 9.5) and event.position.y <= ((eventpos.y / 10) * 9.5) and event.position.y >= ((eventpos.y / 10) * 7)
		if BackSpot and allow:
			print(eventpos)
			get_tree().change_scene_to_file("res://Gameplay_Scenes/main_menu.tscn")

func _on_timer_timeout() -> void:
	allow = true
