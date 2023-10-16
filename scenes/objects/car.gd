extends PathFollow2D

var player_near: bool = false


func _process(delta):
	progress_ratio += 0.05 * delta
	if player_near:
		$TurretMain.look_at(Globals.player_pos)


func _on_area_2d_body_entered(body):
	player_near = true

