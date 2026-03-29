extends Node2D

var credits = 10

func _ready():
	pass

func _on_Timer_timeout():
	
	if credits == 0:
		$CanvasLayer/MarginContainer/Label5.visible = false
		$Timer.stop()
		
	if credits == 1:
		$CanvasLayer/MarginContainer/Label5.visible = true
		$CanvasLayer/MarginContainer/Label4.visible = false
		credits -= 1
	if credits == 2:
		$CanvasLayer/MarginContainer/Label5.visible = false
		credits -= 1
	if credits == 3:
		$CanvasLayer/MarginContainer/Label4.visible = true
		$CanvasLayer/MarginContainer/Label3.visible = false
		credits -= 1
	if credits == 4:
		$CanvasLayer/MarginContainer/Label4.visible = false
		
		credits -= 1
	if credits == 5:
		$CanvasLayer/MarginContainer/Label3.visible = true
		$CanvasLayer/MarginContainer/Label2.visible = false
		
		credits -= 1
	if credits == 6:
		$CanvasLayer/MarginContainer/Label3.visible = false
		
		credits -= 1
	if credits == 7:
		$CanvasLayer/MarginContainer/Label2.visible = true
		$CanvasLayer/MarginContainer/Label.visible = false
		credits -= 1
	if credits == 8:
		$CanvasLayer/MarginContainer/Label2.visible = false
		
		credits -= 1
	if credits == 9:
		$CanvasLayer/MarginContainer/Label.visible = true
		credits -= 1
	if credits == 10:
		$CanvasLayer/MarginContainer/Label.visible = false
		credits -= 1
