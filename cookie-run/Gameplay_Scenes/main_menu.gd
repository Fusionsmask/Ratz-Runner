extends CanvasLayer


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		$Timer.start()
		$VBoxContainer/Label2.text = ("wow")
	pass


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
