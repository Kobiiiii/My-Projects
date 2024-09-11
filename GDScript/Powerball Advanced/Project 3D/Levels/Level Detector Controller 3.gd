extends Spatial

var scene_name
onready var animationPlayer = get_node("../AnimationPlayer")

func _ready():
	introduction()

func _process(delta):
	Database.LHWDB = 3
	_check()
	
func _on_L7D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 7.tscn"
		animationPlayer.play("Circle_close")

func _L7D_enable():
	$L7D/L7Label.modulate = Color(1,1,1,1)
	$L7D.monitoring = true
	$L7D/L7Label.text = "Level 7"

func _on_L8D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 8.tscn"
		animationPlayer.play("Circle_close")

func _L8D_enable():
	$L8D/L8Label.modulate = Color(1,1,1,1)
	$L8D.monitoring = true
	$L8D/L8Label.text = "Level 8"
	
func _on_L9D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 9.tscn"
		animationPlayer.play("Circle_close")
	
func _L9D_enable():
	$L9D/L9Label.modulate = Color(1,1,1,1)
	$L9D.monitoring = true
	$L9D/L9Label.text = "Level 9"
	
func _on_L10D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 10.tscn"
		animationPlayer.play("Circle_close")
		
func _L10D_enable():
	$L10D/L10Label.modulate = Color(1,1,1,1)
	$L10D.monitoring = true
	$L10D/L10Label.text = "Level 10"
	
func _on_NLHW3_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 4 Hub World.tscn"
		animationPlayer.play("Circle_close")

func _NLHW3_enable():
	$"NLHW3/NLHW Label".modulate = Color(1,1,1,1)
	$NLHW3.monitoring = true
	$"NLHW3/NLHW Label".text = "Go To Hub World 4"
	
func _check():
	if Database.levels["Level 7"].isCompleted == true:
		_L8D_enable()
	if Database.levels["Level 8"].isCompleted == true:
		_L9D_enable()
	if Database.levels["Level 9"].isCompleted == true:
		_L10D_enable()
	if Database.levels["Level 10"].isCompleted == true:
		_NLHW3_enable()
		Database.levels["Next Level Hub 3"].isCompleted = true
		Database._save_level_data()
func _on_AnimationPlayer_animation_finished(anim_name):
	Database.allowed_to_pause = true
	get_tree().change_scene(scene_name)

func introduction():
	yield(get_tree().create_timer(2),"timeout")
	$"../Tween".interpolate_property($"../Title", "rect_position", Vector2(100,-44), Vector2(100,0), 1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$"../Tween".start()
