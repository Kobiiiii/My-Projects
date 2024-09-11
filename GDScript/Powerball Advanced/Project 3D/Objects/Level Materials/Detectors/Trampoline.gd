extends Spatial

onready var player = get_node("../../Player")

func _on_Area_body_entered(body):
	if body.name == "Player":
		player.is_bouncing = true
		$Bounce_timer.set_wait_time(0.2)
		$Bounce_timer.start()
		

func _on_Bounce_timer_timeout():
	player.is_bouncing = false
	$Bounce_timer.stop()
