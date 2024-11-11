extends ItemContainer

func hit():
	if not opened:
		opened = true
		$LidSprite.hide()
		var pos = $SpawnPositions/Marker2D.global_position
		open.emit(pos, current_direction)
