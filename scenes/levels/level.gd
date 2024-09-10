extends Node2D

var test_array: Array[String] = ["Hello", "World", "Stuff"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Car.rotation_degrees = 45
	
	for i in test_array:
		print(i)
	
	print(test_array[0])

func _process(delta):
	$Car.rotation_degrees += 40 * delta
		
	if $Car.position.x > 1000:
		print('position exceeded')
		$Car.pos.x = 0 
		
	#print(Input.is_action_pressed("left"))
	
