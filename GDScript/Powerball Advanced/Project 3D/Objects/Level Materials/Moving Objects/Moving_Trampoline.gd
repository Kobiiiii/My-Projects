extends KinematicBody

var target_velocity = Vector3.ZERO
var move_left: bool = false

onready var player = get_node("../../Player")

func _ready():
	$"Switch Timer".start()

func _on_Area_body_entered(body):
	if body.name == "Player":
		player.is_bouncing = true
		$Bounce_timer.set_wait_time(0.2)
		$Bounce_timer.start()
		

func _on_Bounce_timer_timeout():
	player.is_bouncing = false
	$Bounce_timer.stop()

func _physics_process(delta):
	var direction = Vector3.ZERO

	if move_left == true:
		direction.x -= 1 # facing the left.
	else:
		direction.x +=1

	target_velocity.x = direction.x * 5 # moving the direction to the target_velocity with a speed of 5.
	target_velocity.z = direction.z * 5
	
	move_and_slide(target_velocity)

func _on_Switch_Timer_timeout():
	if move_left == false:
		move_left = true
	else:
		move_left = false
