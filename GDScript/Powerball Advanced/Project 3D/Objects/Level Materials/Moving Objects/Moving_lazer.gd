extends KinematicBody

var target_velocity = Vector3.ZERO
var move_left: bool = false
	
func _ready():
	$"RigidBody/Switch Timer".start()

func _physics_process(delta):
		
	var direction = Vector3.ZERO

	if move_left == true:
		direction.x -= 1 # facing the left.
	else:
		direction.x +=1

	target_velocity.x = direction.x * 5 # moving the direction to the target_velocity with a speed of 5.
	target_velocity.z = direction.z * 5
	
	var collider = $RigidBody/MeshInstance/RayCast.get_collider()
	$RigidBody/ImmediateGeometry.clear()
	$RigidBody/ImmediateGeometry.begin(Mesh.PRIMITIVE_LINES)
	$RigidBody/ImmediateGeometry.add_vertex(Vector3.ZERO)
	$RigidBody/ImmediateGeometry.add_vertex(to_local($RigidBody/MeshInstance/RayCast.get_collision_point()))
	$RigidBody/ImmediateGeometry.end()
	
	if collider.name == "Player":
		print(collider.name)

	
	move_and_slide(target_velocity)

func _on_Switch_Timer_timeout():
	if move_left == false:
		move_left = true
	else:
		move_left = false

