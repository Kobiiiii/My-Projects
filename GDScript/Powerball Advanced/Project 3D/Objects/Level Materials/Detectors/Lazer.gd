extends Spatial
	
func _process(delta):
	var collider = $MeshInstance/RayCast.get_collider()
	$ImmediateGeometry.clear()
	$ImmediateGeometry.begin(Mesh.PRIMITIVE_LINES)
	$ImmediateGeometry.add_vertex(Vector3.ZERO)
	$ImmediateGeometry.add_vertex(to_local($MeshInstance/RayCast.get_collision_point()))
	$ImmediateGeometry.end()
	
func _physics_process(delta):
	var collider = $MeshInstance/RayCast.get_collider()
	if collider.name == "Player":
		collider.animationPlayer.play("death")
		
