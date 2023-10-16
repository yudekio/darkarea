extends Node

signal stats_change



var laser_amount = 20:
	set(value):
		laser_amount = value
		stats_change.emit()
		
var grenade_amount = 5:
	set(value):
		grenade_amount = value
		stats_change.emit()
		
var health = 100:
	set(value):
		health = value
		stats_change.emit()
		print(health)


var player_pos: Vector2
