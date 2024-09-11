extends CanvasLayer

func _ready():
	$Timer.start()
	
func _unhandled_key_input(event):
	if event.is_pressed() and Database.just_opened == false:
		$AnimationPlayer.play("closing")
		Database.just_opened = true
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "opening":
		$AnimationPlayer.play("press play")
	if anim_name == "closing":
		queue_free()
func _on_Timer_timeout():
	$Timer.stop()
	if Database.just_opened == false:
		$AnimationPlayer.play("opening")
		
func _on_TextureButton_button_down():
	$AnimationPlayer.play("closing")
	Database.just_opened = true
