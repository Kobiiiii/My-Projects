extends KinematicBody

var target_velocity = Vector3.ZERO
var move_left: bool = false

func _ready():
	$"Switch Timer".start()

func _physics_process(delta):
	var direction = Vector3.ZERO

	if move_left == true:
		direction.x -= 1 # facing the left.
	else:
		direction.x +=1

	target_velocity.x = direction.x * 7 # moving the direction to the target_velocity with a speed of 5.
	target_velocity.z = direction.z * 7
	
	move_and_slide(target_velocity)
	
func _on_Area_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()

func _on_Switch_Timer_timeout():
	if move_left == false:
		move_left = true
	else:
		move_left = false
