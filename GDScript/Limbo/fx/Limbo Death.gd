extends GPUParticles2D

signal ready_to_trans

func _ready():
	$AnimationPlayer.play("die")

func _on_animation_player_animation_finished(anim_name):
	emit_signal("ready_to_trans")
	queue_free()
	
