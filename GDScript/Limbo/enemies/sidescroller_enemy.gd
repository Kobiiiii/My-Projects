extends CharacterBody2D

var gravity: int = 30

var speed: int = 30
var knockDir: Vector2
var knockSpeed: int = 30
var is_knockback: bool = false
var enemyHealth: int = 20
var enemyDamage: int = 1
var drop_id: int = 0
var score = 100

@onready var player = get_parent().get_parent().get_node("Player")
@onready var coin = preload("res://Scenes/collectable/coin.tscn")
@onready var heart = preload("res://Scenes/collectable/heart.tscn")
@onready var stopwatch = preload("res://Scenes/collectable/stopwatch.tscn")

func _physics_process(delta):
	_states()
	velocity.y = gravity 
	move_and_slide()
	
func _states():
	if is_knockback == true:
		knockback()
	if is_knockback == false:
		moving()
	if enemyHealth == 0:
		GameManager.score += score
		drop_item()
		queue_free()
		
func moving():
	$Sprite2D.play("default")
	var l_collider = $L_Wallcheck.get_collider()
	var r_collider = $R_Wallcheck.get_collider()
	if not $Left_Check.is_colliding():
		velocity.x = speed
	if not $Right_Check.is_colliding():
		velocity.x = -speed
	if $L_Wallcheck.is_colliding():
		velocity.x = speed
	if $R_Wallcheck.is_colliding():
		velocity.x = -speed
	move_and_slide()
	
func drop_item():
	drop_id = randi_range(1,3)
	match drop_id:
		1:
			var coinInstance = coin.instantiate()
			get_parent().add_child(coinInstance)
			coinInstance.global_position = global_position
			coinInstance.animationPlayer.play("spawn")
		2:
			var heartInstance = heart.instantiate()
			get_parent().add_child(heartInstance)
			heartInstance.global_position = global_position
		3:
			var watchInstance = stopwatch.instantiate()
			get_parent().add_child(watchInstance)
			watchInstance.global_position = global_position
			
func knockback():
	velocity = knockDir * knockSpeed*2
	move_and_slide()

func _on_enemy_box_area_entered(area):
	if area.name == "CollisionDetector":
		var bullet = area.get_parent()
		enemyHealth -= bullet.damage
		$knock_timer.start()
		knockDir = bullet.direction
		is_knockback = true

func _on_knock_timer_timeout():
	is_knockback = false
