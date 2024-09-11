extends Area2D

@onready var player = get_parent().get_parent().get_node("Player")
@onready var particles = preload("res://Scenes/fx/key_collected.tscn").instantiate()

func _ready():
	$AnimationPlayer.play("spawning")
	
func _on_body_entered(body):
	if body.name == "Player":
		player.has_key = true
		summon_particles()
		$AnimatedSprite2D.visible = false
		$Sprite2D.visible = false

func _on_animation_player_animation_finished(anim_name):
	$AnimationPlayer.play("idle")

func summon_particles():
	add_child(particles)
	particles.global_position = global_position
