extends Label

func _ready():
	$AnimatedSprite2D.play("default")
	
func _process(delta):
	text = str(GameManager.coins)
