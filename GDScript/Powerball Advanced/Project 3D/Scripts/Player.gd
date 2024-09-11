extends RigidBody

var rolling_force = 3

# Power Effect Booleans.
var is_floating: bool = false
var is_speeding: bool = false
var is_slowing:  bool = false
var is_bouncing: bool = false
var is_knockback: bool = false
# Jumping Boolean.
var is_inair:    bool = false
var landing:     bool = false

# Moving Variables.
var move = Vector3.ZERO

var killing = false
var particles = preload("res://Textures/player_particles.tscn")
var jump_particles = preload("res://Textures/player_particles_jump.tscn")
onready var pause_menu = preload("res://ui_elements/pause_menu.tscn")
onready var animationPlayer: AnimationPlayer = $AnimationPlayer
var step = false
var ball_color

func _ready():
	sleeping = false
	ball_color = $"Players Parts/Body".get_surface_material(0)
	ball_color.albedo_color = Color(1,1,1,1)
	Database.pausing = false 
	killing = false
	$AnimationPlayer.play("Circle_open")
	$Timer.start()
	if Database.just_opened == false:
		opening()
# So the Camera and FloorChecker do not move with the balls rotations.
	$CameraRig.set_as_toplevel(true)
	$FloorChecker.set_as_toplevel(true)

func _process(delta):
	move = Vector3.ZERO
	if Database.just_opened and killing == false:
		_inputs(delta)
	if Database.allowed_to_pause == true:
		_pausing()
	_floor_detection()
	_threshold_death()
	_power_effects()
	step_particles()
	landing_particles()
	
# Player Movement Physics.
	apply_central_impulse(Vector3(move.x*2*delta,move.y*2*delta,move.z*2*delta))
	apply_torque_impulse(Vector3(rolling_force*move.z*delta, rolling_force*move.y*delta, rolling_force*-move.x*delta))

# Moves the Camera and FloorChecker move with the ball.
	$CameraRig.global_transform.origin = lerp($CameraRig.global_transform.origin, global_transform.origin, 0.1)
	$FloorChecker.global_transform.origin = global_transform.origin

func _inputs(delta):
	if Input.is_action_pressed("ui_up"):
		move.z = -1
	if Input.is_action_pressed("ui_down"):
		move.z = 1
	if Input.is_action_pressed("ui_left"):
		move.x = -1
	if Input.is_action_pressed("ui_right"):
		move.x = 1

	if Input.is_action_just_pressed("ui_accept") and is_inair == false:
		apply_central_impulse(Vector3(0,4,0))
		var stepParticles = jump_particles.instance()
		get_parent().add_child(stepParticles)
		stepParticles.global_translation = Vector3(self.global_translation.x,self.global_translation.y - 1,self.global_translation.z)
		$FloorChecker.enabled = false
		landing = true
	elif Input.is_action_just_released("ui_accept"):
		is_inair = true

func _power_effects():
	ball_color = $"Players Parts/Body".get_surface_material(0)
	if is_floating == true:
		apply_impulse(Vector3(), Vector3(0,0.085,0))
		is_inair = true
	if is_speeding == true:
		apply_impulse(Vector3(), Vector3(0,0,-0.17))
		apply_impulse(Vector3(), Vector3(0,0.085 ,0))
		angular_velocity.y = 0
	if is_slowing == true:
		self.set_angular_velocity(Vector3())
		self.set_linear_velocity(Vector3.ZERO)
	if is_bouncing == true:
		apply_central_impulse(Vector3(0,0.9,0))
		is_inair = true
	if is_knockback == true:
		apply_central_impulse(Vector3(0,0,0.8))
		yield(get_tree().create_timer(0.3),"timeout")
		is_knockback = false
		yield(get_tree().create_timer(3),"timeout")
		$Tween.interpolate_property($Label,"rect_position",Vector2(31,207),Vector2(31,258),1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
		$Tween.start()
func _floor_detection():
	if $FloorChecker.is_colliding() == true:
		is_inair = false
	if is_inair == true:
		$FloorChecker.enabled = true
		
func _threshold_death():
	if global_translation.y < -50 and killing == false:
		$AnimationPlayer.play("death")
		Database.allowed_to_pause = false
		killing = true
		sleeping = true
		
		 
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Circle_close":
		Database.allowed_to_pause = true
		get_tree().reload_current_scene()
	if anim_name == "death":
		$AnimationPlayer.play("Circle_close")
func opening():
	$Tween.interpolate_property($CameraRig/SpringArm,"translation",Vector3(0,30,0),Vector3(0,self.global_translation.y,0), 10, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.interpolate_property($CameraRig/SpringArm/Camera,"rotation_degrees",Vector3(25,0,0),Vector3(-16.18,0,0), 10, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	$Tween.start()

func step_particles():
	if step == true:
		var stepParticles = particles.instance()
		get_parent().add_child(stepParticles)
		stepParticles.global_translation = Vector3(self.global_translation.x, self.global_translation.y - 1, self.global_translation.z) 
		step = false

func landing_particles():
	if landing == true and $FloorChecker.is_colliding() == true:
		var stepParticles = jump_particles.instance()
		get_parent().add_child(stepParticles)
		stepParticles.global_translation = Vector3(self.global_translation.x,self.global_translation.y - 1,self.global_translation.z)
		landing = false

func _pausing():
	if Input.is_action_just_pressed("pause"):
		Database.pausing = true
		var menu = pause_menu.instance()
		get_parent().add_child(menu)
		
func _on_Timer_timeout():
	if Input.is_action_pressed("ui_up") and is_inair == false:
		step = true
	if Input.is_action_pressed("ui_down") and is_inair == false:
		step = true
	if Input.is_action_pressed("ui_left") and is_inair == false:
		step = true
	if Input.is_action_pressed("ui_right") and is_inair == false:
		step = true
	if is_floating:
		step = true
	if is_speeding:
		step = true

func _on_Tween_tween_all_completed():
	Database.allowed_to_pause = true
	
func _on_Area_area_entered(area):
	if area.monitoring == false and area.name.begins_with("L") or area.name.begins_with("N") and area.monitoring == false:
		is_knockback = true
		$Tween.interpolate_property($Label,"rect_position",Vector2(31,258),Vector2(31,207),1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
		$Tween.start()
