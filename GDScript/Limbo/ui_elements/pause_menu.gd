extends CanvasLayer

var settings = Settings.new()
var restarting = false

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($menu,"scale", Vector2(1,1),0.4)
	tween2.tween_property($menu,"rotation_degrees", 360,0.4)
	
func _process(delta):
	if $menu.scale < Vector2.ONE:
		menu_disable()
	else:
		menu_enable()
func _on_continue_pressed():
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($menu,"scale", Vector2(0,0),0.4)
	tween.tween_property($Overlay,"modulate",Color(0,0,0,0), 0.4)
	tween2.tween_property($menu,"rotation_degrees", 0,0.4)
	menu_disable()
	get_tree().paused = false
	process_mode = Node.PROCESS_MODE_INHERIT
	$Timer.start()
func _on_exit_pressed():
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($menu,"scale", Vector2(0,0),0.2).set_ease(Tween.EASE_OUT_IN)
	tween2.tween_property($Decide,"position", Vector2(0,0),0.5).set_trans(Tween.TRANS_EXPO)
	
func _on_options_pressed():
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($menu,"scale", Vector2(0,0),0.2)
	tween2.tween_property($Options,"position", Vector2(0,0),0.5).set_trans(Tween.TRANS_EXPO)

func _on_back_pressed():
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($menu,"scale", Vector2(1,1),0.2)
	tween2.tween_property($Options,"position", Vector2(0,180),0.2).set_trans(Tween.TRANS_EXPO)

func _on_no_pressed():
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($menu,"scale", Vector2(1,1),0.2)
	tween2.tween_property($Decide,"position", Vector2(0,180),0.2).set_trans(Tween.TRANS_EXPO)
	restarting = false
	
func _on_yes_pressed():
	close()

func _on_restart_pressed():
	var tween = create_tween()
	var tween2 = create_tween()
	tween.tween_property($menu,"scale", Vector2(0,0),0.2)
	tween2.tween_property($Decide,"position", Vector2(0,0),0.5).set_trans(Tween.TRANS_EXPO)
	restarting = true
	
func menu_disable():
	for i in $menu.get_children():
		if i is Button:
			i.disabled = true

func menu_enable():
	for i in $menu.get_children():
		if i is Button:
			i.disabled = false
			
func close():
	$AnimationPlayer.play("close")
	$ColorRect.z_index = 3

func _on_animation_player_animation_finished(anim_name):
	if restarting == true:
		get_tree().paused = false
		queue_free()
		get_tree().reload_current_scene()
	else:
		queue_free()
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Scenes/ui_elements/main_menu.tscn")
		
func _on_timer_timeout():
	GameManager.paused = false
	queue_free()
