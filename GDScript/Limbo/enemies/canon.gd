extends StaticBody2D

var direction: Vector2
var ready_to_shoot: bool = false
var loaded: bool = false

var health: int = 100

@export var cooldown_seconds: float = 0.0
@export var flipped = false
@export var down = false
@onready var bullet = preload("res://Scenes/projectiles/canon_bullet.tscn")

func _ready():
	_shoot_directions()
	ready_to_shoot = true
	
func _process(delta):
	$Cooldown_timer.wait_time = cooldown_seconds
	_states()
	
func _states():
	_shoot()
	_shoot_directions()
	_death()
	
func _shoot():
	if ready_to_shoot:
		$Cooldown_timer.start()
		ready_to_shoot = false
		loaded = false
		var bulletInstance = bullet.instantiate()
		get_parent().add_child(bulletInstance)
		bulletInstance.direction = direction
		bulletInstance.global_position = global_position
		bulletInstance.name = "canon_bullet"

func _shoot_directions():
	if flipped == false:
		$Sprite2D.flip_h = false
		direction = Vector2.RIGHT
	if flipped == true:
		$Sprite2D.flip_h = true
		direction = Vector2.LEFT
	if down == true:
		$Sprite2D.rotation_degrees = 90
		direction = Vector2.DOWN
	

func _death():
	if health == 0:
		queue_free()
		
func _on_cooldown_timer_timeout():
	$Sprite2D.play("fire")
	ready_to_shoot = true

func _on_sprite_2d_animation_finished():
	if ready_to_shoot == false and loaded == false:
		$Sprite2D.play("load")
		loaded = true

func _on_area_2d_area_entered(area):
	if area.name == "CollisionDetector":
		var bullets = area.get_parent()
		health -= bullet.damage
