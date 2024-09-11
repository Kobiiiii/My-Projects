extends Node2D

@onready var animationTree: AnimationTree = $AnimationTree

@onready var player = get_parent()

var direction: Vector2

var settings = Settings.new()

func _ready():
	animationTree.active = true
	
func _process(delta):
	_directions()
	_point()
	_correction()
	visibility()
	
func _point():
	animationTree["parameters/conditions/is_aiming"] = true

func _correction():
	if player.direction != Vector2.ZERO:
		animationTree["parameters/aim/blend_position"] = player.direction
	if player.prev_direction == null:
		animationTree["parameters/aim/blend_position"] = Vector2.RIGHT
		
func _directions():
	direction = $Sprite2D.position/10

func visibility():
	visible = settings.aim_arrow
