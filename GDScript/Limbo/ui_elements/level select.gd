extends Node2D

var scene = null

func _ready():
	$AnimationPlayer.play("intro")

func _on_button_pressed():
	scene = "res://Scenes/levels/Level_1.tscn"
	get_tree().change_scene_to_file(scene)

func _on_button_2_pressed():
	scene = "res://Scenes/levels/Level_2.tscn"
	get_tree().change_scene_to_file("res://Scenes/levels/Level_2.tscn")

func _on_button_3_pressed():
	scene = "res://Scenes/levels/Level_3.tscn"
	get_tree().change_scene_to_file("res://Scenes/levels/Level_3.tscn")

func _on_button_4_pressed():
	$AnimationPlayer.play("seperate")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "seperate":
		get_tree().change_scene_to_file("res://Scenes/ui_elements/main_menu.tscn")
