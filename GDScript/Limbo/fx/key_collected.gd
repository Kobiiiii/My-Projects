extends GPUParticles2D

func _ready():
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("die")
	
func _on_animation_player_animation_finished(anim_name):
	get_parent().queue_free()
