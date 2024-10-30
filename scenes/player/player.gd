extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

signal laser_has_fired(pos, direction)
signal grenade_has_fired(pos, direction)

@export var max_speed: int = 500
var speed: int = max_speed


func _process(_delta):
	#input
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	var player_direction = (get_global_mouse_position() - position).normalized()
	#rotate player, to always look at mouse
	look_at(get_global_mouse_position())
	
	
	#laser shooting input
	if Input.is_action_pressed("primary action") and can_laser:
		var laser_markers = $LaserStartPositions.get_children() #gets random point of where laser is going
		var selected_laser = laser_markers[randi() % laser_markers.size()] #selects random laser
		
		$GPUParticles2D.emitting = true;
		
		laser_has_fired.emit(selected_laser.global_position, player_direction) #passes global position to level
		can_laser = false
		await get_tree().create_timer(0.5).timeout #creates timer
		_on_timer_timeout_laser() #refreshes laser
		
	
	if Input.is_action_just_pressed("secondary action") and can_grenade:
		#print("Grenade!")
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
