extends Particles

func _ready():
	$AnimationPlayer.play("appear")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "appear":
		$AnimationPlayer.play("disappear")
	if anim_name == "disappear":
		queue_free()
