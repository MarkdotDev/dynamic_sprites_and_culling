extends Node2D

@export var distance_thresholds: Array[float] = [200.0, 400.0, 600.0]

@onready var sprites = [$SpriteHigh, $SpriteMed, $SpriteLow]

func _ready() -> void:
	for i in sprites.size():
		sprites[i].visible = false
	sprites[0].visible = true

func _process(delta: float) -> void:
	var camera = get_viewport().get_camera_2d()
	if camera:
		var distance = global_position.distance_to(camera.global_position)
		update_sprite_resolution(distance)
		check_culling(camera)

func update_sprite_resolution(distance: float) -> void:
	for sprite in sprites:
		sprite.visible = false

	if distance <= distance_thresholds[0]:
		sprites[0].visible = true
	elif distance <= distance_thresholds[1]:
		sprites[1].visible = true
	else:
		sprites[2].visible = true

func check_culling(camera: Camera2D):
	var viewport_rect = get_viewport_rect()
	var camera_pos = camera.global_position
	var view_top_left = camera_pos - viewport_rect.size / 2
	var view_bottom_right = camera_pos + viewport_rect.size / 2

	var pos = global_position
	if pos.x < view_top_left.x or pos.x > view_bottom_right.x or pos.y < view_top_left.y or pos.y > view_bottom_right.y:
		set_process(false)
		visible = false
	else:
		set_process(true)
		visible = true

func _draw() -> void:
	if Engine.is_editor_hint():
		for i in distance_thresholds.size():
			var color = Color(1, 1, 1, 0.1)
			draw_circle(Vector2.ZERO, distance_thresholds[i], color)
