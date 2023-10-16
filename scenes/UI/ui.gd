extends CanvasLayer

# colors 
var green: Color = Color("6bbfa3")
var red: Color = Color(0.9,0,0,1)

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar
@onready var health_label: Label = $MarginContainer/Label


func _ready():
	Globals.connect("stats_change", update_stats_text)
	update_stats_text()


func update_laser_text():
	update_color(Globals.laser_amount, laser_label, laser_icon)
	
	
func update_grenade_text():
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)
	
	
func update_health_text():
	health_label.text = str(Globals.health)
	health_bar.value = Globals.health
	
	
func update_stats_text():
	update_laser_text()
	update_grenade_text()
	update_health_text()
	
	
func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	label.text = str(amount)
	if amount <= 0:
		label.modulate = red
		icon.modulate = red
	else:
		label.modulate = green
		icon.modulate = green
