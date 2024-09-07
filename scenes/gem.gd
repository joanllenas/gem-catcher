extends Area2D

class_name Gem

signal on_gem_offscreen

@export var _speed: float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position.y += _speed * delta
	if self.position.y > get_viewport_rect().size.y:
		on_gem_offscreen.emit()
		self.set_process(false)
		self.queue_free()
	
