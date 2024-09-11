extends CharacterBody2D

# Player Speed.
var speed = 300

#Other.
@onready var bullet = preload("res://projectiles/Bullet.tscn")

func _physics_process(delta):
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = direction * speed
	move_and_slide()

func _shoot():
	if Input.is_action_just_pressed("ui_accept"):
		var bulletInstance = bullet.instantiate()
		get_parent().add_child(bulletInstance)
		bulletInstance.global_position = global_position
	
