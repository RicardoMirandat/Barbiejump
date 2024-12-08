extends Control

onready var highscore = $main/highscore as Label


func _ready():
	highscore.text ="highscore\n" + str(Global.highscore)
	
	

func _on_startbtn_pressed():
	if get_tree().change_scene("res://scenes/doodle_jump.tscn") != OK:
		print ("algo deu errado")

func _on_quitbtn_pressed():
	get_tree().quit()
