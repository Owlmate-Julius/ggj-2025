extends Control

@onready var border_sprite: Sprite2D = $BorderSprite


func _ready() -> void:
	GlobalEvents.next_step.connect(func():
		next_step()
	)


func next_step():
	GlobalState.current_state += 1
	GlobalState.current_state = GlobalState.current_state % 6
	border_sprite.frame = GlobalState.current_state
