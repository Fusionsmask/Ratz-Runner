extends Node

signal Score_change
signal Combo_change
signal Phase_End
signal Pause_End
signal Start_Jesus
signal Stop_Jesus

#signal Grund

signal Win
signal Win2

var Goal = 1000

var Score: int = 0:
	set(value):
		Score = value
		if(Score >= Goal):
			Phase_End.emit()
		if Score >= 5500:
			Win.emit()
		if Score >= 6500:
			Win2.emit()
		Score_change.emit()

var Phase: int = 	1:
	set(value):
		Phase = value
		if Phase == 3:
			Start_Jesus.emit()
		if Phase == 4:
			Stop_Jesus.emit()

var Direction: = 0

var Pause: bool = true:
	set(value):
		Pause = value
		if(value == false):
			Pause_End.emit()
var Combo: float:
	set(value):
		Combo = value
		Combo_change.emit()
var Player_pos: Vector3

#var Ground:
	#set(value):
		#Ground = value
		#Grund.emit()
