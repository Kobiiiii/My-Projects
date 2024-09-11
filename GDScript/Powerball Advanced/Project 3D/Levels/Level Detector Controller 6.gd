extends Spatial

var scene_name
onready var animationPlayer = get_node("../AnimationPlayer")

func _ready():
	introduction()
	
func _process(delta):
	Database.LHWDB = 6
	_check()
	
# Level 6-1 Detector.
func _on_L20D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 20.tscn"
		animationPlayer.play("Circle_close")

# Level 6-2 Detector.
func _L21D_enable():
	$L21D/L21Label.modulate = Color(1,1,1,1)
	$L21D.monitoring = true
	$L21D/L21Label.text = "Level 21"
	
func _on_L21D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 21.tscn"
		animationPlayer.play("Circle_close")

# Level 6-3 Detector.
func _L22D_enable():
	$L22D/L22Label.modulate = Color(1,1,1,1)
	$L22D.monitoring = true
	$L22D/L22Label.text = "Level 22"
	
func _on_L22D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 22.tscn"
		animationPlayer.play("Circle_close")
	
# Level 6-4 Detector.
func _L23D_enable():
	$L23D/L23Label.modulate = Color(1,1,1,1)
	$L23D.monitoring = true
	$L23D/L23Label.text = "Level 23"
	
func _on_L23D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 23.tscn"
		animationPlayer.play("Circle_close")

# Level 6-5 Detector.
func _L24D_enable():
	$L24D/L24Label.modulate = Color(1,1,1,1)
	$L24D.monitoring = true
	$L24D/L24Label.text = "Level 24"
	
func _on_L24D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 24.tscn"
		animationPlayer.play("Circle_close")

# Level 6-6 Detector.
func _L25D_enable():
	$L25D/L25Label.modulate = Color(1,1,1,1)
	$L25D.monitoring = true
	$L25D/L25Label.text = "Level 25"
	
func _on_L25D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 25.tscn"
		animationPlayer.play("Circle_close")
		
# Level 7-0 Detector.
func _NLHW6_enable():
	$"NLHW6/NLHW Label".modulate = Color(1,1,1,1)
	$NLHW6.monitoring = true
	$"NLHW6/NLHW Label".text = "Go to hub world 7"
	
func _on_NLHW6_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 7 Hub World.tscn"
		animationPlayer.play("Circle_close")

# Checking What Can Be Unlocked or Locked.
func _check():
	if Database.levels["Level 20"].isCompleted == true:
		_L21D_enable()
	if Database.levels["Level 21"].isCompleted == true:
		_L22D_enable()
	if Database.levels["Level 22"].isCompleted == true:
		_L23D_enable()
	if Database.levels["Level 23"].isCompleted == true:
		_L24D_enable() 
	if Database.levels["Level 24"].isCompleted == true:
		_L25D_enable()
	if Database.levels["Level 25"].isCompleted == true:
		_NLHW6_enable()
		Database.levels["Next Level Hub 6"].isCompleted = true
		Database._save_level_data()
func _on_AnimationPlayer_animation_finished(anim_name):
	Database.allowed_to_pause = true
	get_tree().change_scene(scene_name)

func introduction():
	yield(get_tree().create_timer(2),"timeout")
	$"../Tween".interpolate_property($"../Title", "rect_position", Vector2(100,-44), Vector2(100,0), 1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$"../Tween".start()
