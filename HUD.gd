extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func set_missile_cooldown_decimal(decimal):
	get_node("Missile Cooldown Panel/Bar Value").rect_size.x = 160 * decimal

func set_score(score):
	get_tree().root.get_node("Main/HUD/Score Panel/Score Value").text = str(score)