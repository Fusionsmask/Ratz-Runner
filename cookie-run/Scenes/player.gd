extends CharacterBody3D


const SPEED = 15
const JUMP_VELOCITY = 4.5

signal CameraTilt(angle)
signal Change

func _physics_process(delta: float) -> void:

	var input_dir := Input.get_vector("Left", "Right", "ui_up", "ui_down")
	input_dir.x += Globals.Direction
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
		
	CameraTilt.emit(direction.x, delta)
	var wow = Globals.Combo
	$Node3D/Sprite3D.rotation_degrees.y += 5 + Globals.Combo
	
	move_and_slide()
	Globals.Player_pos = global_position

func _on_area_3d_area_shape_entered(_area_rid: RID, _area: Area3D, _area_shape_index: int, _local_shape_index: int) -> void:
	Globals.Combo += 1
	print('close')

func hit():
	Change.emit()
