extends Spatial

var scene_name
onready var animationPlayer = get_node("../AnimationPlayer")

func _ready():
	introduction()
	
func _process(delta):
	Database.LHWDB = 4
	_check()

# Level 4-1 Detector.
func _on_L11D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 11.tscn"
		animationPlayer.play("Circle_close")
		
# Level 4-2 Detector.
func _L12D_enable():
	$L12D/L12Label.modulate = Color(1,1,1,1)
	$L12D.monitoring = true
	$L12D/L12Label.text = "Level 12"

func _on_L12D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 12.tscn"
		animationPlayer.play("Circle_close")

# Level 4-3.
func _L13D_enable():
	$L13D/L13Label.modulate = Color(1,1,1,1)
	$L13D.monitoring = true
	$L13D/L13Label.text = "Level 13"
	
func _on_L13D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 13.tscn"
		animationPlayer.play("Circle_close")
		
# Level 4-4.
func _L14D_enable():
	$L14D/L14Label.modulate = Color(1,1,1,1)
	$L14D.monitoring = true
	$L14D/L14Label.text = "Level 14"
	
func _on_L14D_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 14.tscn"
		animationPlayer.play("Circle_close")

# Level 5-0.
func _NLHW4_enable():
	$"NLHW4/NLHW Label".modulate = Color(1,1,1,1)
	$NLHW4.monitoring = true
	$"NLHW4/NLHW Label".text = "Go To Hub World 5"

func _on_NLHW4_body_entered(body):
	if body.name == "Player":
		Database.allowed_to_pause = false
		scene_name = "res://Levels/Level 5 Hub World.tscn"
		animationPlayer.play("Circle_close")
		
func _check():
	if Database.levels["Level 11"].isCompleted == true:
		_L12D_enable()
	if Database.levels["Level 12"].isCompleted == true:
		_L13D_enable()
	if Database.levels["Level 13"].isCompleted == true:
		_L14D_enable()
	if Database.levels["Level 14"].isCompleted == true:
		_NLHW4_enable()
		Database.levels["Next Level Hub 4"].isCompleted = true
		Database._save_level_data()
func _on_AnimationPlayer_animation_finished(anim_name):
	Database.allowed_to_pause = true
	get_tree().change_scene(scene_name)

func introduction():
	yield(get_tree().create_timer(2),"timeout")
	$"../Tween".interpolate_property($"../Title", "rect_position", Vector2(100,-44), Vector2(100,0), 1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$"../Tween".start()
