extends Spatial

func _on_Finish_body_entered(body):
	if body.name == "Player":
		Database.LevelDoneNotif = get_tree().get_current_scene().get_name()
		Database.levels[Database.LevelDoneNotif].isCompleted = true
		Database._save_level_data()
		Database.stoptimer = true
		$"../congratulations/AnimationPlayer".play("level_complete")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "level_complete":
		$"../AnimationPlayer".play("Circle_close")
	if anim_name == "Circle_close":
		get_tree().change_scene("res://Levels/Level %d Hub World.tscn" % Database.LHWDB)
