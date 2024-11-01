extends LevelParent

func _on_gate_player_entered_gate(_body):
	var tween = create_tween()
	tween.tween_property($Player, "speed",0,.5)
