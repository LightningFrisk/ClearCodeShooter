extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP

func _process(delta: float) -> void:
	position += direction * speed * delta
