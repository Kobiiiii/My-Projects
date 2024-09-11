extends CharacterBody2D

#bullet speed.
var speed = 200
var damage = 10
var direction: Vector2

var out_of_owner: bool = false

@onready var player = get_parent().get_node("Player")

func _process(delta):
	velocity = direction*speed
	states()
	move_and_slide()

func states():
	projectile_check()
	homing_check()
	
func projectile_check():
	if direction == Vector2(-1,-1):
		direction = Vector2.UP
	if direction == Vector2(1,-1):
		direction = Vector2.UP
	if direction == Vector2(-1,1):
		direction = Vector2.DOWN
	if direction == Vector2(1,1):
		direction = Vector2.DOWN

func homing_check():
	if player.homing_ability == true:
		$HomingRange.monitoring = true
		$HomingRange.monitorable = true
	else:
		$HomingRange.monitoring = false
		$HomingRange.monitorable = false
		
func _on_collision_detector_area_entered(area):
	if area.name == "enemyBox":
		queue_free()
		
func _on_collision_detector_body_entered(body):
	if out_of_owner == true and body.name != "Hazards":
		queue_free()
		
	if body.name == "player":
		collision_layer = 2
		collision_mask = 2
		out_of_owner = false
	else:
		collision_layer = 1
		collision_mask = 1
		out_of_owner = true

		
func _on_homing_range_area_entered(area):
	var sun = area.get_parent().get_name()
	if area.name == "enemyBox" and !sun.begins_with("shooter_bullet"):
		var enemy = area.get_parent()
		direction = global_position.direction_to(enemy.global_position)
		velocity = direction*speed
		move_and_slide()

