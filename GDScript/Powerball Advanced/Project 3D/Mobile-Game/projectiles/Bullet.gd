extends CharacterBody2D

#bullet speed.
var speed = 100

@onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	pass
