extends RigidBody2D

@export var speed: int = 750
var explosion_active: bool = false
var explosion_radius: int = 400
var hit_limit: int = 1

func explode_anim():
	$AnimationPlayer.play("explosion")
	explosion_active = true
	
func _process(_delta):
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")

		for target in targets:
			var in_range = target.global_position.distance_to(global_position)< explosion_radius
			if "hit" in target and in_range and hit_limit >= 1:
				if target is CharacterBody2D:
					hit_limit -= 1
					target.hit()
				else:
					target.hit()
	
