extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(100,200)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print('process')
