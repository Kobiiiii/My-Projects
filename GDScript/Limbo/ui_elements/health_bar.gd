extends TextureProgressBar

@onready var player = get_parent()

func _physics_process(delta):
	value = player.health

func _on_kill_timer_timeout():
	$AnimationPlayer.play("close")
