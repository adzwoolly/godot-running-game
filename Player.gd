extends Spatial

const missile_scene = preload("res://Missile.tscn")

enum positions {
	LEFT = 0
	MIDDLE = 1
	RIGHT = 2
}
var position_vectors = {
	0: Vector3(-2.5, 0, -1.2),
	1: Vector3(0, 0, -1.2),
	2: Vector3(2.5, 0, -1.2)
}
var position = positions.MIDDLE

var jump_animation_complete = true
var animation

export var fire_missile_cooldown = 2
var fire_missile_timer = 0

func _ready():
	animation = get_node("AnimationPlayer")
	animation.play("run-animation")

func _process(delta):
	# Called every frame. Delta is time since last frame.
	move_to(delta, position_vectors[position], 5)
	
	fire_missile_timer = max(fire_missile_timer - delta, 0)
	get_tree().root.get_node("Main/HUD").set_missile_cooldown_decimal(1 - (fire_missile_timer / fire_missile_cooldown))

func _input(event):
	if event.is_action_pressed("ui_left"):
		move_left()
	if event.is_action_pressed("ui_right"):
		move_right()
	if event.is_action_pressed("ui_up") and jump_animation_complete:
		jump()
	if event.is_action_pressed("ui_accept"):
		fire_missile()

func _on_AnimationPlayer_animation_finished(anim_name):
	animation.play("run-animation", 0.2)
	
	if anim_name == "jump-animation":
		jump_animation_complete = true

func move_left():
	if position != positions.LEFT:
		position = position - 1

func move_right():
	if position != positions.RIGHT:
		position = position + 1

func jump():
	jump_animation_complete = false
	animation.play("jump-animation", 0.01)

func move_to(delta, target_position, speed):
	var current_position = translation
	if current_position.distance_to(target_position) > 0.05:
		var x_diff = target_position.x - current_position.x
		var y_diff = target_position.y - current_position.y
		var z_diff = target_position.z - current_position.z
		var total_diff = abs(x_diff) + abs(y_diff) + abs(z_diff)
		var velocity = Vector3(x_diff / total_diff, y_diff / total_diff, z_diff / total_diff) * speed
		global_translate(velocity * delta)

func fire_missile():
	if fire_missile_timer == 0:
		fire_missile_timer = fire_missile_cooldown
		var missile = missile_scene.instance()
		get_tree().root.add_child(missile)
		missile.global_translate(translation + Vector3(0, 1.8, -1))
