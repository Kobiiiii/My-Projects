extends Spatial

onready var animationPlayer = get_node("../AnimationPlayer")
var scene_name
var ready = false 

func _process(delta):
	introduction()
	_check()
	Database.LHWDB = 1
	
# Level 1-1 Detector.
func _on_L1D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 1.tscn"
		animationPlayer.play("Circle_close")
		
# Level 1-2 Detector.
func _on_L2D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 2.tscn"
		animationPlayer.play("Circle_close")
		
func _L2D_enable():
	$L2D/L2Label.modulate = Color(1,1,1,1)
	$L2D.monitoring = true
	$L2D/L2Label.text = "Level 2"

# Level 1-3 Detector.
func _on_L3D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 3.tscn"
		animationPlayer.play("Circle_close")
		
func _L3D_enable():
	$L3D/L3Label.modulate = Color(1,1,1,1)
	$L3D.monitoring = true
	$L3D/L3Label.text = "Level 3"

# Level 2-0 Detector.
func _on_NLHW_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 2 Hub World.tscn"
		animationPlayer.play("Circle_close")
		
func _NLHW1_enable():
	$"NLHW/NLHW Label".modulate = Color(1,1,1,1)
	$NLHW.monitoring = true
	$"NLHW/NLHW Label".text = "Go to Level Hub 2"
# Checking What Can Be Unlocked or Locked.
func _check():
	if Database.levels["Level 1"].isCompleted == true:
		_L2D_enable()
	if Database.levels["Level 2"].isCompleted == true:
		_L3D_enable() 
	if Database.levels["Level 3"].isCompleted == true:
		_NLHW1_enable()
		Database.levels["Next Level Hub 1"].isCompleted = true
		Database._save_level_data()
		
func _on_AnimationPlayer_animation_finished(anim_name):
	Database.allowed_to_pause = true
	get_tree().change_scene(scene_name)

func introduction():
	if Database.just_opened == true and ready == false:
		yield(get_tree().create_timer(1),"timeout")
		$"../Tween".interpolate_property($"../Title", "rect_position", Vector2(100,-44), Vector2(100,0), 1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
		$"../Tween".start()
		ready = true
