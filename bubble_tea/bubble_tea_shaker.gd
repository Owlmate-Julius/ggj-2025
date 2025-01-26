extends Area2D

@onready var anim: AnimationPlayer = $AnimationPlayer


func _on_interaction_component_has_interacted() -> void:
	if GlobalState.current_state == 4:
		GlobalEvents.next_step.emit()
		anim.play("shake")
		await get_tree().create_timer(3.0).timeout
		anim.play("RESET")
