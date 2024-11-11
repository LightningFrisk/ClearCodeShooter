extends LevelParent

func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed",0,.5)
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")

func _on_house_player_entered() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(.8,.8), 1).set_trans(Tween.TRANS_QUAD)


func _on_house_player_exited() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(.55,.55), 2)
