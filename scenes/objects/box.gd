extends ItemContainer

func hit():
	if not opened:
		opened = true
		$LidSprite.hide()
		#var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
		for i in range(5):
			var pos = $SpawnPositions.get_child(randi()%$SpawnPositions.get_child_count()).global_position
			open.emit(pos, current_direction)
