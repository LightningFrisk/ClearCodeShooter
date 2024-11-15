extends CharacterBody2D

var player_near: bool = false
var active: bool = false
var can_damage:bool = true
var speed: int = 300

var health: int = 20

func hit():
	var direction = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	
	if active:
		move_and_slide()

func _process(_delta):
	if player_near:
		look_at(Globals.player_pos)

func _on_notice_area_2d_body_entered(_body: Node2D) -> void:
	active = true

func _on_notice_area_2d_body_exited(_body: Node2D) -> void:
	active = false

func _on_attack_area_2d_body_entered(_body: Node2D) -> void:
	player_near = true

func _on_attack_area_2d_body_exited(_body: Node2D) -> void:
	player_near = false
