extends Node

func _ready():
	var randomNum = RandomNumberGenerator.new()
	var enemyScene = load("res://Characters/Logger/Logger.tscn")
	var screen_size = get_viewport().get_visible_rect().size
	
	
	for i in range(0, 20):
		var logger = enemyScene.instance()
		randomNum.randomize()
		var x = randomNum.randf_range(0, screen_size.x)
		randomNum.randomize()
		var y = randomNum.randf_range(0, screen_size.y)
		logger.position.y = y
		logger.position.x = x
		add_child(logger) 
