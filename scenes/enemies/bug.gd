extends CharacterBody2D

var active: bool = false
var speed: int = 300
var vulnerable: bool = true
var player_near: bool = false

var health = 30
var player_ref


func _ready():
	$HPBar.max_value = health
	$HPBar.value = health

func hit():
	health -= 10
	$HPBar.value -= 10
	$Particles/HitParticles.emitting = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0.8)
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)
	if health <= 0:
		await get_tree().create_timer(0.1).timeout
		queue_free()
	

func _process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		move_and_slide()

func _on_attack_area_body_entered(body):
	player_ref = body
	player_near = true
	while player_near:
		$AnimatedSprite2D.play("attack")
		await get_tree().create_timer(0.5).timeout
		$AnimatedSprite2D.play("attack")


func _on_attack_area_body_exited(_body):
	player_near = false
	$AnimatedSprite2D.stop()

func _on_notice_area_body_entered(_body):
	active = true
	$AnimatedSprite2D.play("walk")

func _on_notice_area_body_exited(_body):
	active = false
	$AnimatedSprite2D.stop()


func _on_animated_sprite_2d_animation_finished():
	if player_near:
		if "hit" in player_ref:
			player_ref.hit()
			print('kus')
		
	
