extends Area2D


func _on_interaction_component_has_interacted() -> void:
	if GlobalState.current_state == 2:
		GlobalEvents.next_step.emit()
