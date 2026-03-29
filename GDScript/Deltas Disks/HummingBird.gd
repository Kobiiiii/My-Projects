extends KinematicBody2D

#pyhsics
var motion = Vector2.ZERO
var direction: Vector2
var isMoving = false
export var speed = 10


#tween
var delay_between_move = 1
onready var tween = $Tween

#random
var rng = RandomNumberGenerator.new()
var ready_to_rng = false
var ran_x
var ran_y
var rand_pos_from_bird
var rand_pos_from_delta
var stand_still
var spread = 5

# States.
var with_delta = false
var current_state: Vector2
var can_charge_delta = false

var bird_state

enum states {
	idle,
	attacking,
}

#Delta
onready var Delta = get_tree().get_current_scene().get_node("Tommy")

func _ready(): 
	enter_state(states.idle)
	ready_to_rng = true
	
func _process(delta):
	flip_to_delta()
	changing_directons()
	process_states(delta)
	
	motion = move_and_slide(motion, Vector2.ZERO)
	
func enter_state(pass_state):
	if (bird_state != pass_state):
		bird_state = pass_state
		
	match bird_state:
		states.idle:
			$AnimationPlayer.play("idle")
			
		states.attacking:
			$AnimationPlayer.play("going_to_charge")
			cancel_delta_detection_area()
			isMoving = false
			
			yield(get_tree().create_timer(.6),"timeout")
			can_charge_delta = true
			
			$AnimationPlayer.play("attacking")
			
			yield(get_tree().create_timer(.5),"timeout")
			can_charge_delta = false
			isMoving = true
			enter_state(states.idle)

func process_states(delta):
	match bird_state:
		states.idle:
		# This happens ONLY when the bird has chosen a direction to move in.
			if isMoving:
				fly_around(delta, with_delta)
		states.attacking:
			if can_charge_delta:
				global_position = lerp(global_position, rand_pos_from_delta,  delta * speed)

# The tween goes to the player's current position.
# After the humming bird goes to the player it adds a random
# number on the x and y ranging with the spread.
# This allows for the humming bird to surround the player.
func move_to_delta(delta):
# Get Bird to move to delta.
	global_position = lerp(global_position,Delta.global_position, delta*speed)

func move_around_delta(delta):
	global_position = lerp(global_position,Delta.global_position, delta*speed)

func fly_around(delta, with):
	rand_pos_from_bird = global_position + direction
	rand_pos_from_delta = Delta.global_position + direction
	
	stand_still = global_position
	if with_delta:
		current_state = stand_still
		spread = 30
		
		enter_state(states.attacking)
		
		print("fly around attack delta")
		
	else:
		spread = 5
		current_state = rand_pos_from_bird

	global_position = lerp(global_position, current_state,  delta * speed)
	
	
func attack():
	if current_state == rand_pos_from_delta and ran_y < -spread:
		var current_pos = global_position
		
		yield(get_tree().create_timer(10),"timeout")
		global_position = lerp(global_position,Delta.global_position, speed)
		global_position = lerp(global_position,global_position, speed)
		
		isMoving = false
# Inside this function, it allows the bird to pick a random direction.
# After the direction gets chosen it turn on isMoving so it starts moving.
# As we want the randomised function to run once the boolean will instantly turn false.
# We don't set direction to zero here or else the bird will instantly forget where to go.
func changing_directons():
	if bird_state == states.idle:
		if ready_to_rng:
			$Timer.start()
			
			direction = randomised()
			
			isMoving = true
			ready_to_rng = false
			

func flip_to_delta():
	var distance_between = Delta.global_position - self.global_position
	$AnimatedSprite.flip_h = distance_between.x > 0
	
func randomised():
	rng.randomize()
	# Creating the spread.
	ran_x = rng.randi_range(-spread, spread)
	ran_y = rng.randi_range(-spread, spread)
		
	return Vector2(ran_x, ran_y)

func _on_Timer_timeout():
	if bird_state == states.idle:
		isMoving = false
		ready_to_rng = true
		direction = Vector2.ZERO

func cancel_delta_detection_area():
	with_delta = false
	
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	yield(get_tree().create_timer(1.75),"timeout")
	
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	isMoving = false
	ready_to_rng = true
	direction = Vector2.ZERO

func _on_Area2D_body_entered(body):
	with_delta = true
func _on_Area2D_body_exited(body):
	with_delta = false


func _on_AttackZone_body_entered(body):
	if body.name == "Tommy":
		body.damage()
