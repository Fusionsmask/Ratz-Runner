extends Node3D

var allow: bool = false
@onready var Zoom_Camera = $MapCam
var ZM = false

func _process(delta: float) -> void:
	if allow and ZM == false:
		$Control.visible = true
	else:
		$Control.visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		var eventpos = DisplayServer.window_get_size()
		var ZoomSpot = event.position.x >= ((eventpos.x / 2) - 250) and event.position.x <= ((eventpos.x / 2) - 90) and event.position.y <= ((eventpos.y / 2) - 160) and event.position.y >= ((eventpos.y / 2) - 250)
		var BackSpot = event.position.x >= ((eventpos.x / 10) * 8.2) and event.position.x <= ((eventpos.x / 10) * 9.5) and event.position.y <= ((eventpos.y / 10) * 9.5) and event.position.y >= ((eventpos.y / 10) * 7)
		if ZoomSpot and Zoom_Camera.current == false:
			ZM = true
		
		if BackSpot and allow and ZM == false:
			print(eventpos)
			get_tree().change_scene_to_file("res://Gameplay_Scenes/main_menu.tscn")
		
		if Zoom_Camera.current == true:
			ZM = false
		
		Zoom_Camera.current = ZM

func _on_timer_timeout() -> void:
	allow = true
