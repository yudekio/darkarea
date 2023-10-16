extends CharacterBody2D

var laser_scene: PackedScene = preload("res://scenes/project_tiles/laser.tscn")

var player_nearby: bool = false
var can_laser: bool = true
var right_gun_use: bool = true

var health: int = 30

signal laser(pos, direction)

func hit():
	print('scout was hit')
	health -= 10
	$Sprite2D.material.set_shader_parameter("progress", 0.8)
	await get_tree().create_timer(0.1).timeout
	$Sprite2D.material.set_shader_parameter("progress", 0)
	if health <= 0:
		queue_free()

func _process(_delta):

	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var marker_node = $LaserSpawnPositions.get_child(right_gun_use)
			right_gun_use = not right_gun_use
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$LaserCooldown.start()
			
		


func _on_attack_area_body_entered(_body):
	player_nearby = true


func _on_attack_area_body_exited(_body):
	player_nearby = false


func _on_laser_cooldown_timeout():
	can_laser = true
