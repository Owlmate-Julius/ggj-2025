extends StaticBody2D




func _on_interaction_component_has_interacted() -> void:
	if GlobalState.current_state == 5:
		GlobalEvents.deliver_order.emit()
		GlobalEvents.next_step.emit()
		
