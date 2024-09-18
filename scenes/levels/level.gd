extends Node2D

func _on_gate_player_entered_gate(body):
	print("player has entered gate")
	print(body)


func _on_player_grenade_has_fired() -> void:
	print("player has fired grenade")


func _on_player_laser_has_fired() -> void:
	print("player has fired laser")
