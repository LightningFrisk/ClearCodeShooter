extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true
var can_damage: bool = true

signal laser_has_fired(pos, direction)
signal grenade_has_fired(pos, direction)
#signal update_stats

@export var max_speed: int = 500
var speed: int = max_speed

func hit():
	print("Player was hit")
	Globals.health -= 10
	#if can_damage: #this works, but guide does it in globals so he can show off create_timer
		#Globals.health -= 10
		#print(Globals.health)
		#can_damage = false
		#$DamageCooldown.start()
	#if Globals.health <= 0:
		#queue_free()

func _process(_delta):
	#input
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	
	
	#rotate player, to always look at mouse
	look_at(get_global_mouse_position())
	
	var player_direction = (get_global_mouse_position() - position).normalized() #direction - position, normalize everything
	
	
	#laser shooting input
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		var laser_markers = $LaserStartPositions.get_children() #gets random point of where laser is going
		var selected_laser = laser_markers[randi() % laser_markers.size()] #selects random laser
		
		$GPUParticles2D.emitting = true;
		
		laser_has_fired.emit(selected_laser.global_position, player_direction) #passes global position to level
		can_laser = false
		await get_tree().create_timer(0.3).timeout #creates timer
		_on_timer_timeout_laser() #refreshes laser
		
	
	if Input.is_action_just_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		#print("Grenade!")
		Globals.grenade_amount -= 1
		var grenade_markers = $LaserStartPositions.get_children() #gets random point of where grenade is going
		var selected_grenade = grenade_markers[randi() % grenade_markers.size()] #selects random grenade starting point
		
		grenade_has_fired.emit(selected_grenade.global_position, player_direction)
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

#func _on_damage_cooldown_timeout() -> void:
	#can_damage = true
