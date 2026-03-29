extends KinematicBody2D

# random positioning and lerp.
var rand_x
var rand_y
var rand_pos: Vector2 # To track where the fairy is moving to.
export var spread = 20

# States
var is_moving: bool
var is_chasing: bool

<<<<<<< Updated upstream
var fairy_state

enum states {
	idle,
	transform,
	chasing
}

=======
>>>>>>> Stashed changes
# movement.
export var speed = 5
export var chase_speed = 3.5
export var time_between_pause = 1
var current_pos: Vector2

#Delta
onready var Delta = get_tree().get_current_scene().get_node("Tommy")

func _ready():
	is_moving = true
	#Log_current_pos()
<<<<<<< Updated upstream
	enter_state(states.idle,null)
	rand_pos = randomised_point()
	
func _physics_process(delta):
	flip()
	process_states(delta)
#	print(fairy_state)


func enter_state(pass_state, delta):
	if (fairy_state != pass_state):
		fairy_state = pass_state
		
	match fairy_state:
		states.idle:
			pass
		states.transform:
			if is_moving == true:
				agro()
			else:
				fairy_state = states.chasing
		states.chasing:
			chasing(delta)
			
func process_states(delta):
	# Just initiating the chase state
	if $AnimatedSprite.animation == "get_angry" and $AnimatedSprite.frame == 4:
		is_chasing = true
		fairy_state = states.chasing
	
	match fairy_state:
		states.idle:
			idle_move(delta)
		states.chasing:
			chasing(delta)
=======
	rand_pos = randomised_point()
	
func _physics_process(delta):
	states(delta)
	print(is_chasing)
	
func states(delta):
	idle_move(delta)
	chasing(delta)
	flip()
>>>>>>> Stashed changes

# Just remember if the fairy isn't idle it's chasing and attacking delta.
# Just to make shorter if statemenets I only check if the fairy is chasing or not.
func idle_move(delta):
	if is_moving == true and !is_chasing:
		$AnimatedSprite.play("idle")
		# Randomising points for the fairy to move to.
		global_position = lerp(global_position, rand_pos, speed*delta)
		
		if round(global_position.x) == round(rand_pos.x):
			rand_pos = randomised_point()
		
func randomised_point():
	# Randomising x and why to create a point.
	rand_x = rand_range(-spread, spread)
	rand_y = rand_range(-spread, spread)
	
	return Vector2(rand_x, rand_y)
	
# is_moving is just to check agro and to make chasing true so it can switch the idle and chasing states.
func agro():
<<<<<<< Updated upstream
	$AnimatedSprite.play("get_angry")
	is_moving = false #to allow the animation to play once
		
func chasing(delta):
		

=======
	if is_moving == true:
		$AnimatedSprite.play("get_angry")
		is_moving = false #to allow the animation to play once
		
func chasing(delta):
	# Just initiating the chase state
	if $AnimatedSprite.animation == "get_angry" and $AnimatedSprite.frame == 4:
		is_chasing = true
>>>>>>> Stashed changes
		
	if is_chasing:
		global_position = lerp(global_position, Delta.global_position, chase_speed * delta)
		$AnimatedSprite.play("chase_angry")
		yield(get_tree().create_timer(time_between_pause), "timeout")
		is_chasing = false
	else:
		yield(get_tree().create_timer(time_between_pause), "timeout")
		is_chasing = true
	

func flip():
	$AnimatedSprite.flip_h = global_position.x < Delta.global_position.x

func _on_Area2D_body_entered(body):
	if body.name == "Tommy":
<<<<<<< Updated upstream
		enter_state(states.transform, null)
=======
		agro()

>>>>>>> Stashed changes
#func Log_current_pos():
#	current_pos = global_position
