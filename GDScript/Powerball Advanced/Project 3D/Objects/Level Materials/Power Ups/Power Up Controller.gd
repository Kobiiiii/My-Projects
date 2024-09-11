extends Spatial

onready var player = get_node("../../Player")

func _process(delta):
	$"Power Label".text = str("Power Float:%01d" % $pfTimer.time_left)
	if Input.is_action_pressed("ui_cancel"):
		_powerfloat_enable()

# Power Float.
func _on_powerfloat_body_entered(body):
	if body.name == "Player":
		player.is_floating = true
		_powerfloat_disable()

func _powerfloat_disable():
	self.visible = false
	$powerfloat.monitoring = false
	$pfTimer.start()
	$Tween.interpolate_property($"Power Label","rect_position",Vector2(-150,0), Vector2(0,0),0.5,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$Tween.interpolate_property($Cancel_Label,"rect_position",Vector2(400,215), Vector2(213,215),0.5,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$Tween.interpolate_property(player.ball_color,"albedo_color", Color(1,1,1,1), Color(0,1,0,1),1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	$"Power Label".visible = true
	$Cancel_Label.visible = true
	
func _powerfloat_enable():
	self.visible = true
	$powerfloat.monitoring = true
	player.is_floating = false
	$pfTimer.stop()
	$Tween.interpolate_property($"Power Label","rect_position",Vector2(0,0), Vector2(-150,0),1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$Tween.interpolate_property($Cancel_Label,"rect_position",Vector2(213,215), Vector2(400,215),1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$Tween.interpolate_property(player.ball_color, "albedo_color", Color(0,1,0,1), Color(1,1,1,1),1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	
func _on_pfTimer_timeout():
	_powerfloat_enable()
