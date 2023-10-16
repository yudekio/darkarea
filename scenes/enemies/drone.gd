extends CharacterBody2D

var active: bool = false
var speed: int = 400

func _process(_delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		move_and_slide()
	
func hit():
	print("damage")


func _on_notice_area_body_entered(body):
	active = true
