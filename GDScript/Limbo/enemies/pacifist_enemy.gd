extends CharacterBody2D

# Enemy speed.
var followSpeed = 20
var regularSpeed = 30
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
var projectile = false

# Enemy Stats.
var enemyHealth: int = 30
var enemyDamage: int = 1
var drop_id: int = 0

# Other.
@onready var player = get_node("../../Player")
@onready var bullet = preload("res://Scenes/projectiles/homing_bullet.tscn")
@onready var coin = preload("res://Scenes/collectable/coin.tscn")
@onready var heart = preload("res://Scenes/collectable/heart.tscn")
@onready var stopwatch = preload("res://Scenes/collectable/stopwatch.tscn")

func _process(delta):
	states(delta)
	
func knockback():
	velocity = knockDir * knockSpeed*2
	move_and_slide()

func _shoot():
	if is_shooting == true and projectile == false and enemyHealth != 0:
		projectile = true
		var bulletInstance = bullet.instantiate()
		get_parent().add_child(bulletInstance)
		bulletInstance.global_position = global_position
		bulletInstance.dead.connect(change_projectile)
		bulletInstance.start_hit_timer.connect(start_knock_timer)
		
func chase(delta): 
		$Sprite2D.play("idle")
		direction = global_position.direction_to(player.position)
		velocity = direction * followSpeed
		is_moving = false
		move_and_slide()
		
func states(delta):
	_display_health()
	if is_chasing == true:
		chase(delta)
	if enemyHealth == 0:
		drop_item()
		queue_free()
	if is_knockback == true:
		knockback()
	if is_shooting == true:
		_shoot()

func _display_health():
	$Health.text = str(enemyHealth/10)
	
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
		is_shooting = true
		
func _on_chase_range_body_exited(body):
	if body == player:
		is_chasing = false
		is_shooting = false

# ---------- Custom Signals ----------
func change_projectile():
	projectile = false

func start_knock_timer():
	$knock_timer.start()
# ------------------------------------
	
func _on_knock_timer_timeout():
	is_knockback = false
	$knock_timer.stop()
