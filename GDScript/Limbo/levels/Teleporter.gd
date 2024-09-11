extends Area2D

@export var teleport_to: Vector2

@export var cl_left: int
@export var cl_right: int
@export var cl_up: int
@export var cl_down: int

@export var is_sidescroller: bool

@onready var player = get_parent().get_parent().get_node("Player")
@onready var player_camera = get_parent().get_parent().get_node("Player/Camera2D")
@onready var player_animationTree = get_parent().get_parent().get_node("Player/AnimationTree")
@onready var player_animationTree_s = get_parent().get_parent().get_node("Player/AnimationTree_s")

@onready var transition_player = get_parent().get_parent().get_node("Transition/AnimationPlayer")
@onready var transition = get_parent().get_parent().get_node("Transition")

	
func _on_body_entered(body):
	if body.name == "Player":
		transitioning()

func perspective_change():
	if is_sidescroller == true:
		player_animationTree.active = false
		player_animationTree_s.active = true
	if is_sidescroller == false:
		player_animationTree.active = true
		player_animationTree_s.active = false

func transitioning():
	transition.ready_to_change.connect(change)
	transition_player.play("fade_in")
	
func change():
	player.emit_signal("need_platform")
	player.global_position = teleport_to
	player_camera.limit_left = cl_left
	player_camera.limit_right = cl_right
	player_camera.limit_top = cl_up
	player_camera.limit_bottom = cl_down
	perspective_change()
	transition.ready_to_change.disconnect(change)
