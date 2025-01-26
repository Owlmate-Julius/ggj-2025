@icon("res://assets/icons/skin_icon.png")
class_name CustomerSkin extends Node2D

@onready var head_sprite: Sprite2D = $Head/HeadSprite
@onready var hair_sprite: Sprite2D = $Head/HairSprite
@onready var face_sprite: Sprite2D = $Head/FaceSprite
@onready var shirt_sprite: Sprite2D = $Shirt/ShirtSprite
@onready var pants_sprite: Sprite2D = $Pants/PantsSprite
@onready var right_hand_sprite: Sprite2D = $RightHand/RightHandSprite
@onready var left_hand_sprite: Sprite2D = $LeftHand/LeftHandSprite
@onready var anim: AnimationPlayer = $AnimationPlayer


const SKIN_TONES = 4
const HAIR_TYPES = 4
const FACE_TYPES = 4


func _ready() -> void:
	generate()



func generate() -> void:
	var skintone = randi_range(0, SKIN_TONES-1)
	head_sprite.frame += skintone
	hair_sprite.frame += randi_range(0, HAIR_TYPES-1)
	face_sprite.frame += randi_range(0, FACE_TYPES-1)
	right_hand_sprite.frame += skintone
	left_hand_sprite.frame += skintone
	pass
