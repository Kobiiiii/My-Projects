extends Node

var scene_name
onready var particles = preload("res://Objects/Level Materials/Detectors/LD_Particles.tscn")
onready var animationPlayer = get_node("../AnimationPlayer")

func _ready():
	introduction()
	
func _process(delta):
	Database.LHWDB = 2
	_check()
# Level 2-1 Detector.
func _on_L4D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 4.tscn"
		animationPlayer.play("Circle_close")

# Level 2-2 Detector.
func _on_L5D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 5.tscn"
		animationPlayer.play("Circle_close")
func _LD5_enable():
	$L5D/L5Label.modulate = Color(1,1,1,1)
	$L5D.monitoring = true
	$L5D/L5Label.text = "Level 5"
	
# Level 2-3 Detector.
func _on_L6D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 6.tscn"
		animationPlayer.play("Circle_close")

# Level 3-0 Detector.
func _on_NLHW2_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 3 Hub World.tscn"
		animationPlayer.play("Circle_close")

func _NLHW2_enable():
	$"NLHW2/NLHW Label".modulate = Color(1,1,1,1)
	$NLHW2.monitoring = true
	$"NLHW2/NLHW Label".text = "Go to Level Hub 3"
	
func _LD6_enable():
	$L6D/L6Label.modulate = Color(1,1,1,1)
	$L6D.monitoring = true
	$L6D/L6Label.text = "Level 6"

# Checking What Can Be Unlocked or Locked.
func _check():
	if Database.levels["Level 4"].isCompleted == true:
		_LD5_enable()
	if Database.levels["Level 5"].isCompleted == true:
		_LD6_enable()
	if Database.levels["Level 6"].isCompleted == true:
		_NLHW2_enable()
		Database.levels["Next Level Hub 2"].isCompleted = true
		Database._save_level_data()
func _on_AnimationPlayer_animation_finished(anim_name):
	Database.allowed_to_pause = true
	get_tree().change_scene(scene_name)

func introduction():
	yield(get_tree().create_timer(2),"timeout")
	$"../Tween".interpolate_property($"../Title", "rect_position", Vector2(100,-44), Vector2(100,0), 1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$"../Tween".start()
