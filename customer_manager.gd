class_name CustomerManager extends Node2D

@export var CustomerScene : PackedScene
@export var customer_queue_path : Path2D
@export var customer_count_limit := 5
@export var customer_distance := 20.0
@export var path_end : PathFollow2D
@export var walking_speed := 4.0

@onready var spawn_timer: Timer = $SpawnTimer

var customer_count := 0
var path_follow_queue : Array[PathFollow2D] = []


func _ready() -> void:
	spawn_timer.start()
	spawn_timer.wait_time = 3.0


func _process(delta: float) -> void:
	process_queue()


func process_queue():
	for idx in path_follow_queue.size():
		var path_follow : PathFollow2D = path_follow_queue[idx]
		if idx == 0:
			path_follow.progress_ratio += walking_speed * 0.001
			continue
		if path_follow.progress + customer_distance < path_follow_queue[idx-1].progress:
			path_follow.progress_ratio += walking_speed * 0.001


func spawn_customer() -> void:
	customer_count += 1
	var customer : Customer = CustomerScene.instantiate()
	var path_follow = append_to_queue(customer)
	customer.global_position = customer_queue_path.curve.get_point_position(0)
	customer.appear()
	customer.appeared.connect(func():
		path_follow_queue.append(path_follow)
	)


func append_to_queue(customer : Customer) -> PathFollow2D:
	var path_follow = PathFollow2D.new()
	path_follow.rotates = false
	path_follow.loop = false
	customer.path_follow = path_follow #@redundant
	customer_queue_path.add_child(path_follow)
	path_follow.add_child(customer)
	return path_follow


func remove_first_from_queue() -> void:
	var path_follow : PathFollow2D = path_follow_queue.pop_front() as PathFollow2D
	var customer : Customer = path_follow.get_child(0)
	path_follow.remove_child(customer)
	path_follow.queue_free()


func _on_spawn_timer_timeout() -> void:
	if customer_count < customer_count_limit:
		spawn_customer()
