extends CharacterBody2D

var active: bool = false
var can_damage:bool = true
var speed: int = 225
var player_near: bool = false

var health: int = 20

func hit():
	if can_damage:
		health -= 10
	if health <= 0:
		queue_free()

func _process(_delta):
	var direction = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	if active:
		move_and_slide()
		look_at(Globals.player_pos)
	#if player_near:
		

func _on_notice_area_2d_body_entered(_body: Node2D) -> void:
	active = true
	$AnimatedSprite2D.play("walk")

func _on_notice_area_2d_body_exited(_body: Node2D) -> void:
	active = false
	$AnimatedSprite2D.stop()

func _on_attack_area_2d_body_entered(_body: Node2D) -> void:
	player_near = true
	$AnimatedSprite2D.play("attack")

func _on_attack_area_2d_body_exited(_body: Node2D) -> void:
	player_near = false
	$AnimatedSprite2D.play("walk")


func _on_animated_sprite_2d_animation_finished() -> void:
	if player_near:
		Globals.health -= 10


func _on_attack_timer_timeout() -> void:
	pass # Replace with function body.


func _on_hit_timer_timeout() -> void:
	pass # Replace with function body.
