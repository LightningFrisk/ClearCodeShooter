extends Area2D

var rotation_speed: int = 2
var available_types = ['laser','laser','laser','laser','grenade', 'health']
var type = available_types[randi()%len(available_types)]
#var type = "health"

var direction: Vector2
var distance: int = randi_range(150,250)

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color(.1,.2,.8)
	if type == 'grenade':
		$Sprite2D.modulate = Color(.8,.2,.1)
	if type == 'health':
		$Sprite2D.modulate = Color(.1,.8,.1)
	
	#tween
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self,"position",target_pos,.5)
	tween.tween_property(self,"scale", Vector2(1,1),.3).from(Vector2(0,0))

func _process(delta):
	rotation += rotation_speed * delta
	
func _on_body_entered(_body: Node2D) -> void:
	#body.add_item(type)
	if type == 'laser':
		Globals.laser_amount += 5
	if type == 'grenade':
		Globals.grenade_amount += 2
	if type == 'health':
		Globals.health += 10
		
	queue_free()
