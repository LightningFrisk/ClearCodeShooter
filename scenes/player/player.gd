extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

signal laser_has_fired
signal grenade_has_fired


func _process(_delta):
	#input
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * 500
	move_and_slide()
	
	#laser shooting input
	if Input.is_action_just_pressed("primary action") and can_laser:
		#print("Bang!")
		laser_has_fired.emit()
		can_laser = false
		await get_tree().create_timer(0.5).timeout
		_on_timer_timeout_laser()
		
	
	if Input.is_action_just_pressed("secondary action") and can_grenade:
		#print("Grenade!")
		grenade_has_fired.emit()
		can_grenade = false
		await get_tree().create_timer(2.0).timeout
		#found this method on stackoverflow it works fine too if I wanted to do this via code, but u can do this with nodes too
		_on_grenade_reload_timer_timeout()


func _on_timer_timeout_laser() -> void:
	#print("reload laser")
	can_laser = true

func _on_grenade_reload_timer_timeout() -> void:
	#print("reload grenade")
	can_grenade = true
