extends Node2D

var testVariable = "Hello World!"

func _process(delta):
	#input
	var direction = Input.get_vector("left","right","up","down")
	position += direction * 400 * delta
	
	#laser shooting input
	if Input.is_action_pressed("primary action"):
		print("Bang!")
	
	if Input.is_action_pressed("secondary action"):
		print("Grenade!")
