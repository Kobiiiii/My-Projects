extends CharacterBody2D

# Player Speed.
const knockSpeed = 3
const jumpSpeed = 300
var speed = 150

# Player Directions.
var direction: Vector2
var prev_direction
var knockdir
var jumpDir = Vector2.ZERO

# Player States.
var has_key: bool = false
var isCooldown: bool = false
var isInvinsible: bool = false
var justDied: bool = false
var showParts: bool = false
@export var boost: bool = false
@export var isKnockback: bool = false
@onready var animationTree: AnimationTree = $AnimationTree
@onready var animationTree_s: AnimationTree = $AnimationTree_s

# Player Ability States.
var homing_ability: bool = false
var triple_bullets: bool = false

# Player Sidescrolling perspective.
var gravity = 27

#Other.
var kyoteTime: float
var health: int = 10
var hit_score = 1
signal need_platform
@onready var bullet = preload("res://Scenes/projectiles/Bullet.tscn")
@onready var death_particles = preload("res://Scenes/fx/Limbo Death.tscn").instantiate()
@onready var aim_arrow = get_node("aim_arrow")
@onready var health_kill_timer = get_node("health_bar/Kill_Timer")
@onready var transition_player = get_parent().get_node("Transition/AnimationPlayer")
@onready var transition = get_parent().get_node("Transition")
@export var joystick_right : VirtualJoystick

func _ready():
	justDied = false
	death_particles.ready_to_trans.connect(change)
	animationTree.active = true # Top-Down Perspective
	animationTree_s.active = false # Sidescrolling Perspective
func _process(delta):
	if joystick_right and joystick_right.is_pressed:
		rotation = joystick_right.output.angle()
	_shoot()
	if animationTree.active == false:
		$Shadow.visible = false
		_move_s()
		_states_s(delta)
		
	if animationTree.active == true:
		$Shadow.visible = true
		_move(delta)
		_states()
	
func _move(delta):
	if boost == false:
		direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
		velocity = direction * speed 
	move_and_slide()

#--------------- Sidescroller section. ---------------
func _move_s():
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
	else:
		velocity.x = 0
	
	velocity.y = velocity.y + gravity
	move_and_slide()
	
func _states_s(delta):
	_idle_s()
	_jump_s(delta)
	_knockback_s()
	_blend_positions_s()
	_directions()
	_correction_s()
	_invincible()
	_kyote_timer()
	_death()
	_power_up_states()

func _kyote_timer():
	if is_on_floor():
		kyoteTime = 4
	else:
		kyoteTime -= 0.5
		
func _idle_s():
	if velocity == Vector2.ZERO:
		animationTree_s["parameters/conditions/is_idle"] = true
		animationTree_s["parameters/conditions/is_walking"] = false
	else:
		animationTree_s["parameters/conditions/is_idle"] = false
		animationTree_s["parameters/conditions/is_walking"] = true
		
func _directions():
	if velocity.x < 0:
		direction = Vector2.LEFT
	elif velocity.x > 0:
		direction = Vector2.RIGHT
		
func _jump_s(delta):
	if Input.is_action_pressed("ui_accept") and kyoteTime > 0:
		animationTree_s["parameters/conditions/is_jumping"] = true
		velocity.y = -jumpSpeed*1.2
		kyoteTime = 0
	else:
		animationTree_s["parameters/conditions/is_jumping"] = false

	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y = 0
		gravity = 25
		
	if velocity.y < -390:
		gravity = 25
	else:
		gravity = 10
		
func hit_knockback_s():
	Input.vibrate_handheld(50)
	isInvinsible = true
	velocity = knockdir * knockSpeed*2
	move_and_slide()
	
func _knockback_s():
	if isKnockback == true:
		GameManager.score -= hit_score
		animationTree_s["parameters/conditions/is_hit"] = true
		hit_knockback_s()
		_show_health()
	else:
		animationTree_s["parameters/conditions/is_hit"] = false
		
func _correction_s():
# Remember, when direction is not 0, an input is being pressed.
	if direction.x != 0.0:
		prev_direction = direction
		
func _blend_positions_s():
	if direction != Vector2.ZERO:
		animationTree_s["parameters/idle_s/blend_position"] = prev_direction
		animationTree_s["parameters/walk_s/blend_position"] = prev_direction
		animationTree_s["parameters/jump_s/blend_position"] = prev_direction
		animationTree_s["parameters/hit_s/blend_position"] = prev_direction
# ---------------------------------------------------------------------
func _shoot():
	if Input.is_action_pressed("ui_focus_next") and isCooldown == false and triple_bullets == false:
		Input.vibrate_handheld(100)
		var bulletInstance = bullet.instantiate()
		get_parent().add_child(bulletInstance)
		bulletInstance.global_position = global_position
		bulletInstance.direction = aim_arrow.direction
		isCooldown = true
		$cooldown_timer.start()
		
func _multishoot():
# step is the distance between one bullet to another
# we use an array to have a slot for each bullet.
	if Input.is_action_just_pressed("ui_focus_next") and isCooldown == false:
		var bullets = [null,null,null]
	
# This spawns every bullet.
		for i in range(3):
			bullets[i] = bullet.instantiate()
			bullets[i].direction = round(aim_arrow.animationTree["parameters/aim/blend_position"])
			bullets[i].global_position = global_position
			bullets[i].speed -= 50*i
			bullets[i].damage = 10
			get_parent().add_child(bullets[i])
			isCooldown = true
			$cooldown_timer.start()
		
func _invincible():
	if isInvinsible == true:
		$AnimationPlayer.play("invinsibility")
		
func _hit_knockback():
	Input.vibrate_handheld(50)
	velocity = knockdir * knockSpeed
	isInvinsible = true
	move_and_slide()

func _jumping():
		jumpDir = velocity.normalized()
		velocity = jumpDir * jumpSpeed
		
func _states():
	_idle()
	_blend_positions()
	_correction()
	_jump()
	_knockback()
	_hazard_collisions()
	_invincible()
	_death()
	
func _idle():
	if velocity == Vector2.ZERO:
		animationTree["parameters/conditions/is_idle"] = true
		animationTree["parameters/conditions/is_walking"] = false
	else:
		animationTree["parameters/conditions/is_idle"] = false
		animationTree["parameters/conditions/is_walking"] = true

func _jump():
	if Input.is_action_pressed("ui_accept") and isKnockback == false:
		animationTree["parameters/conditions/is_jumping"] = true
		_jumping()
	else:
		animationTree["parameters/conditions/is_jumping"] = false
		
func _knockback():
	if isKnockback == true:
		GameManager.score -= hit_score
		_show_health()
		animationTree["parameters/conditions/is_hit"] = true
		_hit_knockback()
	else:
		animationTree["parameters/conditions/is_hit"] = false
	
func _power_up_states():
	if triple_bullets:
		_multishoot()
		
func _blend_positions():
	if direction != Vector2.ZERO:
# it's previous direction for the correction.
		animationTree["parameters/idle/blend_position"] = prev_direction
		animationTree["parameters/walk/blend_position"] = prev_direction
		animationTree["parameters/hit/blend_position"] = prev_direction
		
	if boost:
		animationTree["parameters/jump/blend_position"] = prev_direction
		boost = false
		
func _correction():
# Remember, when direction is not 0, an input is being pressed.
	if direction.x != 0.0:
		prev_direction = direction
	if prev_direction == null:
		direction = Vector2.RIGHT
		prev_direction = direction
		
func _hazard_collisions():
	for i in get_slide_collision_count():
# Collision gets all the individual collisions.
# Name gets the name of what's being collided.
		var collision = get_slide_collision(i)
		var name = collision.get_collider().name
		var push_force = 90.0
		if name == "Hazards":
			knockdir = direction * -30
			health -= 2
			isKnockback = true
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_central_impulse(-collision.get_normal() * push_force)

func _death():
	if health <= 0:
		justDied = true
		showParts = true
		GameManager.score = 0
		boost = true
	if showParts == true and is_instance_valid(death_particles):
		visible = false
		showParts = false
		get_parent().add_child(death_particles)
		death_particles.global_position = global_position

func change():
	death_particles.ready_to_trans.disconnect(change)
	transition_player.play("fade_in")
	
func _show_health():
	$health_bar.visible = true
	$health_bar.modulate = Color(1,1,1,255)
	health_kill_timer.start()
	
func camera_shake(shake_duration : int):
	$Camera2D.offset.x = randi_range(-1,1)
	$Camera2D.offset.y = randi_range(-1,1)

func _on_player_box_area_entered(area):
	if area.name == "enemyBox":
		var enemy = area.get_parent()
		knockdir = enemy.velocity
		health -= enemy.enemyDamage
		isKnockback = true

func _on_cooldown_timer_timeout():
	isCooldown = false
	
func _on_power_timer_timeout():
	if homing_ability == true:
		homing_ability = false
	if triple_bullets == true:
		triple_bullets = false

func _on_animation_player_animation_finished(anim_name):
	if isInvinsible == true:
		isInvinsible = false
