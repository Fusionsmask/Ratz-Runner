extends CanvasLayer


@onready var Scoreboard = $Score_Container/Score
@onready var Combobar = $ProgressBar
@onready var ComboBoard = $Label


func _ready() -> void:
	Globals.connect("Score_change", _Update_Score)
	Globals.connect("Combo_change", _Update_Combo)
	Globals.connect("Win", _Update_Image)
	Globals.connect("Win2", _Update_Image2)
	_Update_Score()
	_Update_Combo()
	_Update_Image2()

func _process(delta: float) -> void:
	Combobar.value -= (30 + Globals.Combo) * delta
	if(Combobar.value <= 0):
		Globals.Combo = 0

func _Update_Score():
	Scoreboard.text = String.num(Globals.Score)

func _Update_Combo():
	ComboBoard.text = String.num(Globals.Combo)
	
	if(Globals.Combo >= 1):
		Combobar.value = 100
	if(Globals.Combo == 0 and Combobar.value > 1):
		Combobar.value = 1

func _Update_Image():
	$TextureRect.visible = true

func _Update_Image2():
	$TextureRect.visible = false
