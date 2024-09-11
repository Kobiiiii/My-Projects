extends Area2D

@onready var player = get_node("../../Player")
@onready var playerTimer = get_node("../../Player/PowerTimer")

@export var cooldown = 3

func _ready():
	$AnimationPlayer.play("idle")
	
func _on_area_entered(area):
	if area.name == "playerBox":
		player.homing_ability = true
		playerTimer.wait_time = cooldown
		playerTimer.start()
		$AnimationPlayer.play("collected")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "collected":
		queue_free()
