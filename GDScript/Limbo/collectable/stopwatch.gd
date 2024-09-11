extends Area2D

@onready var player = get_node("../../Player")
@onready var particles = preload("res://Scenes/fx/heart_collected.tscn")

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
var score = 20

func _ready():
	$AnimationPlayer.play("idle")
	
func _process(delta):
	shadow()
	
func _on_area_entered(area):
	if area.name == "playerBox":
		GameManager.timeIncrease = true
		GameManager.score += score
		summon_particles()
		queue_free()

func summon_particles():
	var particleInstance = particles.instantiate()
	get_parent().add_child(particleInstance)
	particleInstance.global_position = global_position

func shadow():
	if player.animationTree.active == true:
		$Sprite2D2.visible = true
	if player.animationTree.active == false:
		$Sprite2D2.visible = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "spawn":
		$AnimationPlayer.play("idle")
