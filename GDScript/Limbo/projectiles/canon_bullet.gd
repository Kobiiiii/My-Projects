extends CharacterBody2D

var direction: Vector2
var speed = 80

var out_of_owner: bool = false
var enemyDamage: int = 10

func _process(delta):
	velocity = direction * speed
	move_and_slide()

func _on_enemy_box_body_entered(body):
	if out_of_owner == true:
		queue_free()
		
# For the Canon
	if body.name == "canon":
		collision_layer = 2
		collision_mask = 2
		out_of_owner = false
	else:
		collision_layer = 1
		collision_mask = 1
		out_of_owner = true


func _on_enemy_box_area_entered(area):
	if area.name == "CollisionDetector":
		queue_free()

