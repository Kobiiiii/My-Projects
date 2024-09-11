extends CharacterBody2D

# Enemy speed.
var followSpeed = 55
var regularSpeed = 70
var knockSpeed = 100
enum directions {UP,DOWN,LEFT, RIGHT}
var direction = Vector2.ZERO
var knockDir
var enemyState = directions.UP

# States
var is_chasing = false
var is_moving = false
var is_idle = false
var is_knockback = false
var is_shooting = false
var is_shooting_circle = false

# Enemy Stats.
var enemyHealth: int = 50
var enemyDamage: int = 1
var shots: int = 3
var drop_id: int = 0

# Other.
@onready var player = get_node("../../Player")
@onready var bullet = preload("res://Scenes/projectiles/shooter_bullet.tscn")
@onready var coin = preload("res://Scenes/collectable/coin.tscn")
@onready var heart = preload("res://Scenes/collectable/heart.tscn")
@onready var stopwatch = preload("res://Scenes/collectable/stopwatch.tscn")

func _ready():
	idle()
	
func _process(delta):
	states(delta)
	
func idle():
	$Sprite2D.play("idle")
	$idle_Timer.wait_time = 3 # Shooting cannot be longer than idle.
	$idle_Timer.start()
	$move_timer.stop()
	is_moving = false
	is_shooting_circle = true
	velocity = Vector2.ZERO
	
func move():
	is_shooting = false
	velocity = direction * regularSpeed
	move_and_slide()
	match enemyState:
		directions.RIGHT:
			direction = Vector2.RIGHT
		directions.UP:
			direction = Vector2.UP
		directions.LEFT:
			direction = Vector2.LEFT
		directions.DOWN:
			direction = Vector2.DOWN
			
func knockback():
	velocity = knockDir * knockSpeed*2
	move_and_slide()
	
func chase(delta):
		direction = global_position.direction_to(player.position)
		velocity = direction * followSpeed
		is_moving = false
		move_and_slide()
		
func states(delta):
	if is_moving == true:
		move()
	if is_chasing == true:
		chase(delta)
	if enemyHealth == 0:
		drop_item()
		queue_free()
	if is_knockback == true:
		knockback()
	if is_shooting == true and shots != 0:
		shoot()
		is_shooting = false
	if is_shooting_circle == true:
		shoot_circle()
	if shots == 0:
		shots = 3
		
func shoot():
	if direction != Vector2.ZERO:
		$cooldown_timer.start()
		var bulletInstance = bullet.instantiate()
		get_parent().add_child(bulletInstance)
		bulletInstance.direction = direction
		bulletInstance.global_position = global_position
		bulletInstance.name = "shooter_bullet"

func shoot_circle():
	is_shooting_circle = false
# step is the distance between one bullet to another
# we use an array to have a slot for each bullet.
	var step = 37
	var bullets = [null,null,null,null,null,null,null,null]

# This spawns every bullet.
	for i in range(8):
		bullets[i] = bullet.instantiate()
		bullets[i].direction = Vector2.RIGHT.rotated(step*i)
		bullets[i].global_position = global_position
		get_parent().add_child(bullets[i])
		bullets[i].name = "shooter_bullet"
		
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
		
func _on_chase_range_body_entered(body):
	if body == player:
		is_chasing = true
		is_shooting_circle = false
		is_shooting = true
		
func _on_chase_range_body_exited(body):
	if body == player:
		is_chasing = false
		is_shooting = false
		is_shooting_circle = false
		
func _on_idle_timer_timeout():
	is_moving = true
	enemyState = randi()%4
	$move_timer.wait_time = 2
	$move_timer.start()
	$idle_Timer.stop()
	
func _on_move_timer_timeout():
	idle();

func _on_knock_timer_timeout():
	is_knockback = false
	$knock_timer.stop()

func _on_enemy_box_area_entered(area):
	if area.name == "CollisionDetector":
		var bullet = area.get_parent()
		enemyHealth -= bullet.damage
		$knock_timer.start()
		knockDir = bullet.direction
		is_knockback = true 

func _on_cooldown_timer_timeout():
	is_shooting = true
	shots -= 1
	$cooldown_timer.stop()
