extends Label

var time_start: int = 0
var time_now: int = 0
var time_elapsed: int = 0
export var time: int = 0
onready var player = get_parent().get_node("Player")
func _ready():
	Database.stoptimer = false
	introduction()
	time_start = OS.get_unix_time() + time #seconds minutes

func _process(delta):
	low_time()
	time_now = OS.get_unix_time() #gets current time.
	if Database.stoptimer == false:
		time_elapsed = abs(time_now - time_start) #abs makes the numbers inside positive (absolute values).
	self.text = str("%02d:%02d" % [time_elapsed/60, time_elapsed%60])
	if time_elapsed == 0:
		player.animationPlayer.play("death")

func low_time():
	if time_elapsed >= 11:# 10 seconds.
		$Tween.interpolate_property(self,"modulate",Color(1,1,1,1), Color(2,0,0,1),0.5,Tween.TRANS_LINEAR,Tween.EASE_IN)
		$Tween.start()

func introduction():
	$Tween.interpolate_property(self,"rect_position",Vector2(-58,25), Vector2(2,25),0.5,Tween.TRANS_ELASTIC,Tween.EASE_IN_OUT)
	$Tween.start()
