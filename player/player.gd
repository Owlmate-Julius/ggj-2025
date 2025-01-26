class_name Player extends CharacterBody2D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var player_look_sprite: Sprite2D = $PlayerLookSprite

const SPEED = 30.0


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		anim.play("walk")
		player_look_sprite.flip_h = velocity.x < 0.0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("RESET")
	move_and_slide()
