extends CanvasLayer

@export var level_time: int = 0

@onready var transition_player = get_node("../../Transition/AnimationPlayer")
@onready var transition = get_node("../../Transition")

@onready var flag = get_node("../../flag")
@onready var pause = preload("res://Scenes/ui_elements/pause_menu.tscn")
func _ready():
	flag.level_complete.connect(level_complete)
	transition.next_level.connect(next_level)
	GameManager.coins = 0
	GameManager.score = 0
	
# Level timer.
	$level_timer/Timer.wait_time = level_time
	$level_timer/Timer.start()

# Coin counter.
	$coin_counter/AnimatedSprite2D.play("default")
	
func _process(delta):
# Pause Menu.
	if Input.is_action_just_pressed("ui_cancel") and GameManager.paused == false:
		get_tree().paused = true
		GameManager.paused = true
		var pause_menu = pause.instantiate()
		get_parent().add_child(pause_menu)
		
# Score.
	$Score.text = str("%010d" % GameManager.score)

# Level timer.
	$level_timer.text = str("%02d" % $level_timer/Timer.time_left)
	$level_timer2.text = $level_timer.text
	time_increase()
	final_seconds()
#Coin counter.
	$coin_counter.text = str(GameManager.coins)

func level_complete():
	$AnimationPlayer.play("level_complete")
	
func next_level():
	flag.change()
	
func change():
	get_tree().reload_current_scene()

func time_increase():
	if GameManager.timeIncrease == true:
		var tween = create_tween()
		$level_timer/Timer.start($level_timer/Timer.time_left+10)
		$level_timer.modulate = Color.GREEN
		tween.tween_property($level_timer,"modulate",Color.WHITE,1)
		GameManager.timeIncrease = false

func final_seconds():
	if $level_timer/Timer.time_left <= 11:
		var tween = create_tween()
		tween.tween_property($level_timer,"modulate",Color.RED,1)
		
func _on_timer_timeout():
	transition.times_up.connect(change)
	$AnimationPlayer.play("time_out")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "time_out":
		transition_player.play("fade_in")
	if anim_name == "level_complete":
		transition.level_trans = true
		transition_player.play("fade_in")
