extends Area2D

@onready var player = get_node("../../Player")
@onready var particles = preload("res://Scenes/fx/coin_collected.tscn").instantiate()

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
var score = 10

func _ready():
	$AnimationPlayer.play("idle")
	
func _process(delta):
	shadow()
	
func _on_area_entered(area):
	if area.name == "playerBox":
		GameManager.coins += 1
		GameManager.score += score
		$Sprite2D.visible = false
		$Sprite2D2.visible = false
		summon_particles()
		

func summon_particles():
	add_child(particles)
	particles.global_position = global_position

func shadow():
	if player.animationTree.active == true:
		$Sprite2D2.visible = true
	if player.animationTree.active == false:
		$Sprite2D2.visible = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "spawn":
		$AnimationPlayer.play("idle")
