extends Node2D

@export var sprite_count: int = 200
@export var spawn_area: Vector2 = Vector2(2000,2000)

func _ready() -> void:
	var dynamic_sprite = preload("res://dynamic_sprite.tscn")

	for i in sprite_count:
		var sprite = dynamic_sprite.instantiate()
		add_child(sprite)
		sprite.position = Vector2(
			randf_range(-spawn_area.x/2, spawn_area.x/2),
			randf_range(-spawn_area.y/2, spawn_area.y/2)
		)
