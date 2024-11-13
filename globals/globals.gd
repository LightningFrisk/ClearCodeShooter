extends Node

signal laser_change
signal grenade_change
signal health_change

var laser_amount = 20:
	get:
		return laser_amount
	set(value):
		laser_amount = value
		laser_change.emit()
		
var grenade_amount = 5:
	get:
		return grenade_amount
	set(value):
		grenade_amount = value
		grenade_change.emit()

var can_damage: bool = true
var health = 100:
	get:
		return health
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if can_damage:
				health = value
				can_damage = false
				player_can_damage_timer()
				health_change.emit()
		health_change.emit()

func player_can_damage_timer():
	await get_tree().create_timer(.5).timeout
	can_damage = true

var player_pos: Vector2
