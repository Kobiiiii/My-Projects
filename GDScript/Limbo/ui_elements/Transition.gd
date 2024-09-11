extends CanvasLayer

signal ready_to_change
signal times_up
signal next_level

@onready var player = get_parent().get_node("Player")

var level_trans: bool = false

func _ready():
	$AnimationPlayer.play("fade_out")
	
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_in":
		emit_signal("ready_to_change")
		emit_signal("times_up")
		$AnimationPlayer.play("fade_out")
	if player.justDied == true:
		get_tree().reload_current_scene()
	if level_trans == true:
		emit_signal("next_level")
		level_trans = false
		$AnimationPlayer.play("fade_out")
