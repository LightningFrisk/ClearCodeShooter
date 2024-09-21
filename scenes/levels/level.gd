extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(body):
	print("player has entered gate")
	print(body)


func _on_player_grenade_has_fired(pos, direction) -> void:
	print("player has fired grenade")
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade)


func _on_player_laser_has_fired(pos, direction) -> void:
	var laser = laser_scene.instantiate() as Area2D
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.position = pos
	laser.direction = direction
	$Projectiles.add_child(laser)
