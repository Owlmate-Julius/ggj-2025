@icon("res://assets/icons/customer_icon.png")
class_name Customer extends Node2D

signal appeared
signal is_ordering
signal is_leaving

@export var path_follow : PathFollow2D

@onready var gfx: AnimationPlayer = $CustomerLook/GFX
@onready var customer_look: CustomerSkin = $CustomerLook
@onready var order_bubble: Node2D = $OrderBubble

var last_position := Vector2.ZERO
var current_target_position : Vector2

enum States {
	APPEAR,
	QUEUE_IN,
	QUEUE_WAIT,
	ORDER,
	LEAVE
}
var current_state = States.APPEAR


func _ready() -> void:
	customer_look.visible = false


func _physics_process(delta: float) -> void:
	if current_state == States.QUEUE_IN:
		global_position = path_follow.global_position
		if global_position == last_position:
			customer_look.anim.play("idle")
		else:
			customer_look.anim.play("walk")
		last_position = global_position
		if path_follow.progress_ratio >= 0.98:
			emit_signal("is_ordering")
			current_state = States.ORDER
			GlobalEvents.customer_order.emit(self)
			enter_order_state()
			customer_look.anim.play("idle")
	if current_state == States.LEAVE:
		global_position = global_position.move_toward(current_target_position, 0.4)
		customer_look.scale.x = -1

func appear() -> void:
	gfx.play("appear")


func enter_order_state():
	order_bubble.visible = true


func receive_order():
	order_bubble.visible = false


func leave_store(target_position):
	current_state = States.LEAVE
	current_target_position = target_position
	customer_look.anim.play("walk")


func _on_gfx_animation_finished(anim_name: StringName) -> void:
	if anim_name == "appear":
		emit_signal("appeared")
		current_state = States.QUEUE_IN
		customer_look.anim.play("walk")
