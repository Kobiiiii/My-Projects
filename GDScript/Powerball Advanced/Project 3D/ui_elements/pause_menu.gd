extends CanvasLayer

var ret_view: bool = false
var exiting: bool = false
var resetting: bool = false
var selected_level: bool = false
var scene_name

func ready():
	exiting = false
	resetting = false
	selected_level = false
	$AnimationPlayer2.play("RESET")
	$AnimationPlayer.play("introduction")

func _process(delta):
	for i in Database.levels:
		if i.begins_with("Next Level Hub"):
			for f in $Panel3/ScrollContainer/VBoxContainer.get_children():
				var n = f.name.lstrip("Level ")
				var value = Database.levels["Next Level Hub %s" % n].isCompleted
				if value == true:
					f.disabled = false
	
func _on_Retro_View_pressed():
	if ret_view == false:
		$"Panel4/Retro View".text = "HD View"
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT, SceneTree.STRETCH_ASPECT_KEEP,Vector2(160,120),0.5)
		ret_view = true
	else:
		$"Panel4/Retro View".text = "Retro View"
		ret_view = false
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP,Vector2(160,120),0.5)

func _on_Exit_pressed():
	$AnimationPlayer.play("paused_to_ays")
	exiting = true

func _on_No_pressed():
	$AnimationPlayer.play("ays_to_paused")
	if exiting:
		exiting = false

func _on_Yes_pressed():
	$AnimationPlayer2.play("Circle_close")
	
func _on_Back_pressed():
	$AnimationPlayer.play("lhs_to_paused")

func _on_Level_Hub_Select_pressed():
	$AnimationPlayer.play("paused_to_lhs")

func _on_Continue_pressed():
	Database.pausing = false
	$AnimationPlayer.play("leave")
	
func _on_Back2_pressed():
	$AnimationPlayer.play("opt_to_paused")

func _on_Options_pressed():
	exiting = false
	$AnimationPlayer.play("paused_to_opt")
	
func _on_Erase_Data_pressed():
	exiting = false
	$AnimationPlayer.play("opt_to_ays")
	
func _on_Restart_Level_pressed():
	resetting = true
	$AnimationPlayer2.play("Circle_close")
	
func _on_Level_1_pressed():
	selected_level = true
	scene_name = "res://Levels/Level 1 Hub World.tscn"
	$AnimationPlayer2.play("Circle_close")
func _on_Level_2_pressed():
	selected_level = true
	scene_name = "res://Levels/Level 2 Hub World.tscn"
	$AnimationPlayer2.play("Circle_close")
func _on_Level_3_pressed():
	selected_level = true
	scene_name = "res://Levels/Level 3 Hub World.tscn"
	$AnimationPlayer2.play("Circle_close")
func _on_Level_4_pressed():
	selected_level = true
	scene_name = "res://Levels/Level 4 Hub World.tscn"
	$AnimationPlayer2.play("Circle_close")
func _on_Level_5_pressed():
	selected_level = true
	scene_name = "res://Levels/Level 5 Hub World.tscn"
	$AnimationPlayer2.play("Circle_close")
func _on_Level_6_pressed():
	selected_level = true
	scene_name = "res://Levels/Level 6 Hub World.tscn"
	$AnimationPlayer2.play("Circle_close")
func _on_Level_7_pressed():
	selected_level = true
	scene_name = "res://Levels/Level 7 Hub World.tscn"
	$AnimationPlayer2.play("Circle_close")

func _on_AnimationPlayer2_animation_finished(anim_name):
	if selected_level and resetting == false and exiting == false:
		get_tree().change_scene(scene_name)
	if exiting and resetting == false and selected_level == false:
			get_tree().quit()
	elif exiting == false and resetting == false and selected_level == false:
		Database._erase_level_data()
		get_tree().change_scene("res://Levels/Level 1 Hub World.tscn")
	if resetting and exiting == false and selected_level == false:
		get_tree().reload_current_scene()
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "leave":
		queue_free()

