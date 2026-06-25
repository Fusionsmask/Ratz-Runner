extends Node3D

var speed = 50
signal new
var once: bool = true

func _process(delta: float) -> void:
	
	#position.z += (speed + Globals.Combo) * delta
	#
	#if position.z >= 5 and once:
		#Globals.Ground = 1
		#once = false
		#
	#if position.z >= 810:
		#once = true
		#queue_free()
	pass
