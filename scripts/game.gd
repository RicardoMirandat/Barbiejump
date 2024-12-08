extends Node2D

onready var platform_contrainer := $platform_contrainer as Node2D
onready var platfotm_initial_position_y = $platform_contrainer/platform.position.y
onready var camera = $Camera as Camera2D
onready var player := $Player as KinematicBody2D
onready var score_label := $Camera/score as Label
onready var camera_score_position = $Camera.position.y

var last_platform_is_cloud := false
var score := 0

export (Array,PackedScene) var platform_scene

func level_generator(amount):
	for items in amount:
		var new_type = randi() % 4
		
		platfotm_initial_position_y -= rand_range(36,54)
		var new_platform 
		
		if new_type == 0:
			new_platform = platform_scene[0].instance() as StaticBody2D
		elif new_type ==1:
			new_platform = platform_scene[1].instance() as StaticBody2D
		
		elif new_type >=2:
			if last_platform_is_cloud == false and score > 1000:
				new_platform = platform_scene[2].instance() as StaticBody2D
				new_platform.connect("delete_object",self, "delete_object")
				last_platform_is_cloud == true
				
			else:
				new_platform = platform_scene[0].instance() as StaticBody2D
				last_platform_is_cloud = false
			
		if new_type != null:
			new_platform.position = Vector2(rand_range(20,160),platfotm_initial_position_y)
			platform_contrainer.call_deferred("add_child",new_platform)
			pass
	
func _ready() -> void:
	randomize()
	level_generator(20)
	
	
func _physics_process(delta: float) -> void:
	if player.position.y < camera.position.y:
		camera.position.y = player.position.y
	score_update()
	
func delete_object(obstacle):
	if obstacle.is_in_group("player"):
#		get_tree().reload_current_scene()
		if score > Global.highscore:
			Global.highscore = score
		if get_tree().change_scene("res://scenes/titile-screen.tscn") != OK:
			print ("algo deu errado")
	elif obstacle.is_in_group("platform") or obstacle.is_in_group("enemis"):
		obstacle.queue_free()
		level_generator(1)

func _on_platform_cleaner_body_entered(body)-> void:
	delete_object(body)

func score_update():
	score = camera_score_position - camera.position.y
	score_label.text = str(int(score))
