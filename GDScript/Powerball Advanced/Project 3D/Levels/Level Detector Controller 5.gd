extends Spatial

var scene_name
onready var animationPlayer = get_node("../AnimationPlayer")

func _ready():
	introduction()
	
func _process(delta):
	Database.LHWDB = 5
	_check()
# Level 5-1 Detector.
func _L15D_enable():
	$L15D/L15Label.modulate = Color(1,1,1,1)
	$L15D.monitoring = true
	$L15D/L15Label.text = "Level 15"

func _on_L15D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 15.tscn"
		animationPlayer.play("Circle_close")
		
# Level 5-2 Detector.
func _L16D_enable():
	$L16D/L16Label.modulate = Color(1,1,1,1)
	$L16D.monitoring = true
	$L16D/L16Label.text = "Level 16"
	
func _on_L16D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 16.tscn"
		animationPlayer.play("Circle_close")
		
# Level 5-3 Detector.
func _L17D_enable():
	$L17D/L17Label.modulate = Color(1,1,1,1)
	$L17D.monitoring = true
	$L17D/L17Label.text = "Level 17"
	
func _on_L17D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 17.tscn"
		animationPlayer.play("Circle_close")
	
# Level 5-4 Detector.
func _L18D_enable():
	$L18D/L18Label.modulate = Color(1,1,1,1)
	$L18D.monitoring = true
	$L18D/L18Label.text = "Level 18"
	
func _on_L18D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 18.tscn"
		animationPlayer.play("Circle_close")

# Level 5-5 Detector.
func _L19D_enable():
	$L19D/L19Label.modulate = Color(1,1,1,1)
	$L19D.monitoring = true
	$L19D/L19Label.text = "Level 19"

func _on_L19D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 19.tscn"
		animationPlayer.play("Circle_close")

# Level 6-0.
func _NLHW5_enable():
	$"NLHW5/NLHW Label".modulate = Color(1,1,1,1)
	$NLHW5.monitoring = true
	$"NLHW5/NLHW Label".text = "Go To Hub World 6"

func _on_NLHW5_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 6 Hub World.tscn"
		animationPlayer.play("Circle_close")
		
# Checking What Can Be Unlocked or Locked.
func _check():
	if Database.levels["Level 15"].isCompleted == true:
		_L16D_enable()
	if Database.levels["Level 16"].isCompleted == true:
		_L17D_enable()
	if Database.levels["Level 17"].isCompleted == true:
		_L18D_enable()
	if Database.levels["Level 18"].isCompleted == true:
		_L19D_enable()
	if Database.levels["Level 19"].isCompleted == true:
		_NLHW5_enable()
		Database.levels["Next Level Hub 5"].isCompleted = true
		Database._save_level_data()
func _on_AnimationPlayer_animation_finished(anim_name):
	Database.allowed_to_pause = true
	get_tree().change_scene(scene_name)

func introduction():
	yield(get_tree().create_timer(2),"timeout")
	$"../Tween".interpolate_property($"../Title", "rect_position", Vector2(100,-44), Vector2(100,0), 1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$"../Tween".start()
