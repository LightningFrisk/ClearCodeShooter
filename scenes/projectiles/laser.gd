extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP

func _ready() -> void:
	$SelfDestructTimer.start()

func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if "hit" in body:
		body.hit()
	#if "is_enemy" in body:
		#print("is an enemy")
	queue_free()

func _on_self_destruct_timer_timeout() -> void:
	queue_free()
