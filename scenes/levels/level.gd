extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(_body):
	#print("player has entered gate")
	#print(body)
	var tween = create_tween()
	tween.tween_property($Player, "speed",0,.5)


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


func _on_house_player_entered() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	#tween.tween_property($Player, "modulate:a",0,2).from(.5)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(.8,.8), 1).set_trans(Tween.TRANS_QUAD)

func _on_house_player_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(.55,.55), 2)
