extends CanvasLayer

func _process(delta):
	for i in get_children():
		var name = str(i.get_name())
		var number = int(name)
		if GameManager.completed_levels.has(number):
			i.disabled = false
