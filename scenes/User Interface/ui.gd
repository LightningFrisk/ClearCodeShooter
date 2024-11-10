extends CanvasLayer

#colors
var green: Color = Color("6bbfa3") #hex
var red: Color = Color(.9,0,0,1) #rgba tuple

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Grenade
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready():
	Globals.connect("health_change", update_health_text)
	Globals.connect("laser_change", update_laser_text)
	Globals.connect("grenade_change", update_grenade_text)
	
	update_laser_text()
	update_grenade_text()
	update_health_text()
	
func update_color(amount: int, label: Label, icon: TextureRect):
	if amount <= 0:
		label.modulate = red
		icon.modulate = red
	else:
		label.modulate = green
		icon.modulate = green

func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)

func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)

func update_health_text():
	health_bar.value = Globals.health
