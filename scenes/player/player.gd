extends CharacterBody2D 

signal laser_print(pos, direction)
signal grenade(pos, direction)

const MAX_HEALTH: int = 100
var can_laser: bool = true
var can_grenade: bool = true


@export var max_speed: int = 500
var speed: int = max_speed

func _process(_delta):
	
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	
	# rotate
	look_at(get_global_mouse_position())
	var player_direction = (get_global_mouse_position() - position).normalized()
	# laser shooting input
	if Input.is_action_just_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		var laser_markers = $LaserStartPosition.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		laser_print.emit(selected_laser.global_position, player_direction)
		can_laser = false
		$LaserTimer.start()

		
	if Input.is_action_just_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
		var grenade_marker = $MarkerGrenade
		grenade.emit(grenade_marker.global_position, player_direction)
		can_grenade = false
		$GrenadeTimer.start()



func _on_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
	
func hit():
	$PlayerImage.material.set_shader_parameter("progress", 0.8)
	await get_tree().create_timer(0.1).timeout
	$PlayerImage.material.set_shader_parameter("progress", 0)
	Globals.health -= 10
	print('player was hit')

