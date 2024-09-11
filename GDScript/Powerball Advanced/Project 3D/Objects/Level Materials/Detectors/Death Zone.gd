extends Spatial

onready var player = get_node("../../Player")
	
func _ready():
	$AnimationPlayer.play("Circle_open")
	
func _on_Death_Zone_body_entered(body):
	if body.name == "Player":
		_kill()

func _kill():
	Database.allowed_to_pause = false
	player.killing = true
	player.animationPlayer.play("death")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Circle_close":
		Database.allowed_to_pause = true
		get_tree().reload_current_scene()



