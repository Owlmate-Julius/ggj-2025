extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interaction_component_has_interacted() -> void:
	if GlobalState.current_state == 1:
		GlobalEvents.next_step.emit()
