extends CharacterBody2D

var followSpeed: int = 90
var direction: Vector2
var is_chasing = false
var damage = 10
var enemyDamage = 1
var out_of_owner: bool = false

signal dead
signal start_hit_timer 

@onready var player = get_node("../../Player")

func _process(delta):
	if is_chasing == true:
		chase()

func _on_chase_range_body_entered(body):
	if body == player:
		is_chasing = true

func _on_chase_range_body_exited(body):
	if body == player:
		is_chasing == false
		velocity = direction * followSpeed
		move_and_slide()

func chase():
	direction = global_position.direction_to(player.position)
	velocity = direction * followSpeed
	move_and_slide()

func _on_enemy_box_body_entered(body):
	if out_of_owner == true:
		emit_signal("dead")
		queue_free()
		
# Pacifist Enemy hit code.
	if out_of_owner and body.name == "pacifist_enemy":
		body.enemyHealth -= damage
		emit_signal("start_hit_timer")
		body.knockDir = direction
		body.is_knockback = true
		queue_free()
		
	if body.name == "pacifist_enemy":
		collision_layer = 2
		collision_mask = 2
		out_of_owner = false
		
func _on_enemy_box_body_exited(body):
		collision_layer = 1
		collision_mask = 1
		out_of_owner = true
		
func _on_enemy_box_area_entered(area):
	if area.name == "playerbox":
		emit_signal("dead")
		queue_free()
