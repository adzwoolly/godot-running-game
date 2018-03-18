extends Spatial

export var number_of_road_tiles = 3

var score = 0

var lightning_time = 5
var lightning_timer = 0
var flashing = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var road = get_node("World (moves)/Road")
	
	for i in (range(number_of_road_tiles)):
		road.spawn_new_road(i * 20)
	
	road.free()
	
	# Get the viewport and clear it
	var viewport = get_node("ViewportQuad/Viewport")
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)

	# Let two frames pass to make sure the vieport's is captured
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")

	# Retrieve the texture and set it to the viewport quad
	get_node("ViewportQuad").material_override.albedo_texture = viewport.get_texture()

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	lightning(delta)

func lightning(delta):
	if lightning_timer > lightning_time:
		if flashing:
			flashing= false
			get_node("WorldEnvironment").environment.ambient_light_energy = 0.2
			lightning_time = rand_range(7.5, 25)
		else:
			flashing = true
			get_node("WorldEnvironment").environment.ambient_light_energy = 10
			get_node("AudioStreamPlayer3D").play()
			lightning_time = 0.15
		lightning_timer = 0
	
	lightning_timer = lightning_timer + delta

func modify_score(amount):
	score = score + amount
	get_tree().root.get_node("Main/HUD/Panel/Score Value").text = str(score)