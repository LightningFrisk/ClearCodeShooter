extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")

func _on_gate_player_entered_gate(body):
	print("player has entered gate")
	print(body)


func _on_player_grenade_has_fired() -> void:
	print("player has fired grenade")


func _on_player_laser_has_fired() -> void:
	var laser = laser_scene.instantiate()
	
	#TODO UPDATE LASER POSITION
	laser.position = $Player.position
	#TODO MOVE THE LASER
	#TODO ADD LASER TO NOTE 2D
	add_child(laser)
