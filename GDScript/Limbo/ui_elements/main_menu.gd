extends Node2D

var button_pressed = false
func _ready():
	button_pressed = false
	$AnimationPlayer.play("intro")

func _process(delta):
	pass
	
func _on_animation_player_animation_finished(anim_name):
	if button_pressed == false:
		$AnimationPlayer.play("idle")
		$AnimationPlayer2.play("buttons")
	if button_pressed == true:
		get_tree().change_scene_to_file("res://Scenes/ui_elements/level select.tscn")

func _on_animation_player_2_animation_finished(anim_name):
	pass

func _on_button_pressed():
	button_pressed = true
	$AnimationPlayer.play("separate")
	$AnimationPlayer2.play("separate")

func _on_button_2_pressed():
	get_tree().quit()
