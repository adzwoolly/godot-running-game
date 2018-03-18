extends Spatial

const road_scene = preload("res://Road.tscn")
var build_distance

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	build_distance = get_tree().root.get_node("Main").number_of_road_tiles * 20
	
func set_number_of_road_tiles():
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if self.get_global_transform().origin.z >= 10:
		spawn_new_road(build_distance)
		self.queue_free()

func spawn_new_road(distance_ahead):
	var clone = road_scene.instance()
	get_parent().add_child(clone)
	clone.global_transform.origin.z = global_transform.origin.z - distance_ahead
	spawn_new_pickup(distance_ahead)

func spawn_new_pickup(rough_distance_ahead):
	var pickup = load("res://GoodPickup.tscn").instance()
	get_parent().add_child(pickup)
	var distance_variation = rand_range(-5, 5)
	pickup.global_transform.origin.z = global_transform.origin.z - (rough_distance_ahead + distance_variation)
	var spawn_options = [-2.5, 0, 2.5]
	var chosen_option = randi() % 3
	pickup.translate(Vector3(spawn_options[chosen_option], 1.4, 0))