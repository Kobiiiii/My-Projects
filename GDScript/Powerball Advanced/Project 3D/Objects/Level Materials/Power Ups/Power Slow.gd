extends Spatial

onready var player = get_node("../../Player")

func _process(delta):
	$"Powersl Label".text = str("Power Slow:%01d" % $"psl Timer".time_left)
	
func _on_powerslow_body_entered(body):
	if body.name == "Player":
		player.is_slowing = true
		_powerslow_disable()
		
func _powerslow_disable():
	self.visible = false
	$powerslow.monitoring = false
	$"psl Timer".start()
	$"Powersl Label".visible = true
	
func _powerslow_enable():
	self.visible = true
	player.is_slowing = false
	$"psl Timer".stop()
	$"Powersl Label".visible = false
	queue_free()
	
func _on_psl_Timer_timeout():
	_powerslow_enable()
