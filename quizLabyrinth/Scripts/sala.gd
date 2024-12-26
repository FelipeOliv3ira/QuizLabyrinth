extends Resource

class_name SALA

@export var position: Vector3
@export var is_wall: bool

func _init(position: Vector3, is_wall: bool):
	self.position = position
	self.is_wall = is_wall
