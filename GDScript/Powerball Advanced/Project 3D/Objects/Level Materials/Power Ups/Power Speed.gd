extends Spatial

onready var player = get_node("../../Player")

func _process(delta):
	$"Powers Label".text = str("Power Speed:%01d" % $psTimer.time_left)
	
	if Input.is_action_pressed("ui_cancel"):
		_powerspeed_enable()
		
func _on_powerspeed_body_entered(body):
	if body.name == "Player":
		player.is_speeding = true
		_powerspeed_disable()
		
func _powerspeed_disable():
	self.visible = false
	$powerspeed.monitoring = false
	$Tween.interpolate_property($"Powers Label","rect_position",Vector2(-150,0), Vector2(0,0),0.5,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$Tween.interpolate_property($Cancel_Label,"rect_position",Vector2(400,215), Vector2(213,215),0.5,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$Tween.interpolate_property(player.ball_color,"albedo_color", Color(1,1,1,1), Color(0,0,1,1),1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	$psTimer.start()
	$"Powers Label".visible = true
	$Cancel_Label.visible = true
	
func _powerspeed_enable():
	self.visible = true
	$powerspeed.monitoring = true
	$Tween.interpolate_property($"Powers Label","rect_position",Vector2(0,0), Vector2(-150,0),1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$Tween.interpolate_property($Cancel_Label,"rect_position",Vector2(213,215), Vector2(400,215),1,Tween.TRANS_ELASTIC,Tween.EASE_OUT)
	$Tween.interpolate_property(player.ball_color,"albedo_color", Color(0,0,1,1), Color(1,1,1,1),1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	player.is_speeding = false
	$psTimer.stop()

func _on_psTimer_timeout():
	_powerspeed_enable()
