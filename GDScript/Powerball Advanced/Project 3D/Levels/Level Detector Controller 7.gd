extends Spatial

var scene_name
onready var animationPlayer = get_node("../AnimationPlayer")

func _ready():
	introduction()
	
func _process(delta):
	Database.LHWDB = 7
	_check()
	
# Level 7-1 Detector.
func _on_L26D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 26.tscn"
		animationPlayer.play("Circle_close")

# Level 7-2 Detector.
func _L27D_enable():
	$L27D/L27Label.modulate = Color(1,1,1,1)
	$L27D.monitoring = true
	$L27D/L27Label.text = "Level 27"

func _on_L27D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 27.tscn"
		animationPlayer.play("Circle_close")

# Level 7-3 Detector.
func _L28D_enable():
	$L28D/L28Label.modulate = Color(1,1,1,1)
	$L28D.monitoring = true
	$L28D/L28Label.text = "Level 28"
	
func _on_L28D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 28.tscn"
		animationPlayer.play("Circle_close")
		
# Level 7-4 Detector.
func _L29D_enable():
	$L29D/L29Label.modulate = Color(1,1,1,1)
	$L29D.monitoring = true
	$L29D/L29Label.text = "Level 29"
	
func _on_L29D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 29.tscn"
		animationPlayer.play("Circle_close")
		
# Level 7-5 Detector.
func _L30D_enable():
	$L30D/L30Label.modulate = Color(1,1,1,1)
	$L30D.monitoring = true
	$L30D/L30Label.text = "Level 30"
	
func _on_L30D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 30.tscn"
		animationPlayer.play("Circle_close")

# Level 7-6 Detector.
func _L31D_enable():
	$L31D/L31Label.modulate = Color(1,1,1,1)
	$L31D.monitoring = true
	$L31D/L31Label.text = "Level 31"

func _on_L31D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 31.tscn"
		animationPlayer.play("Circle_close")
		
# Checking What Can Be Unlocked or Locked.
func _check():
	if Database.levels["Level 26"].isCompleted == true:
		_L27D_enable()
	if Database.levels["Level 27"].isCompleted == true:
		_L28D_enable()
	if Database.levels["Level 28"].isCompleted == true:
		_L29D_enable()
	if Database.levels["Level 29"].isCompleted == true:
		_L30D_enable() 
	if Database.levels["Level 30"].isCompleted == true:
		_L31D_enable()
	if Database.levels["Level 31"].isCompleted == true:
		Database.levels["Next Level Hub 7"].isCompleted = true
		Database._save_level_data()
func _on_AnimationPlayer_animation_finished(anim_name):
	Database.allowed_to_pause = true
	get_tree().change_scene(scene_name)
	
func introduction():
	yield(get_tree().create_timer(2),"timeout")
	$"../Tween".interpolate_property($"../Title", "rect_position", Vector2(100,-44), Vector2(100,0), 1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$"../Tween".start()
