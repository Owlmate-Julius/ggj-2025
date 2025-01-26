class_name InteractionComponent extends Area2D

signal has_interacted

@export var sprite : Sprite2D

var outline_shader : Shader = preload("res://shaders/outline.gdshader")
var is_inside := false

func _ready() -> void:
	var mat : ShaderMaterial = ShaderMaterial.new() as ShaderMaterial
	mat.shader = outline_shader
	sprite.material = mat


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and is_inside:
		has_interacted.emit()


func _on_body_entered(body: Node2D) -> void:
	sprite.material.set_shader_parameter("width", 1.0)
	sprite.material.set_shader_parameter("number_of_images", Vector2(sprite.hframes,1))
	is_inside = true


func _on_body_exited(body: Node2D) -> void:
	sprite.material.set_shader_parameter("width", 0.0)
	is_inside = false
