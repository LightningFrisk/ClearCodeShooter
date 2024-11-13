extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var can_damage:bool = true
@onready var laser_markers = $LaserSpawnPositions.get_children()
var laser_barrel_select: int = 1

var health: int = 30

signal laser(pos, direction)

func hit():
	if can_damage:
		health -= 10
		can_damage = false
		$Timers/DamageCooldown.start()
		$Sprite2D.material.set_shader_parameter("progress",1)
	if health <= 0:
		queue_free()

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var selected_laser = laser_markers[laser_barrel_select]
			laser_barrel_select = abs(laser_barrel_select - 1)
			var pos: Vector2 = selected_laser.global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$Timers/LaserCooldown.start()

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false

func _on_damage_cooldown_timeout() -> void:
	can_damage = true
	$Sprite2D.material.set_shader_parameter("progress",0)

func _on_laser_cooldown_timeout() -> void:
	can_laser = true
