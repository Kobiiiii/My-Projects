extends Node2D

@onready var player = get_node("Player")
@onready var player_camera = get_node("Player/Camera2D")
@onready var player_animationTree = get_node("Player/AnimationTree")
@onready var player_animationTree_s = get_node("Player/AnimationTree_s")

@export var is_sidescroller: bool

@export var cl_left: int
@export var cl_right: int
@export var cl_up: int
@export var cl_down: int

func _ready():
	perspective_change()
	change()

func perspective_change():
	if is_sidescroller == true:
		player_animationTree.active = false
		player_animationTree_s.active = true
	if is_sidescroller == false:
		player_animationTree.active = true
		player_animationTree_s.active = false

func change():
	player_camera.limit_left = cl_left
	player_camera.limit_right = cl_right
	player_camera.limit_top = cl_up
	player_camera.limit_bottom = cl_down
