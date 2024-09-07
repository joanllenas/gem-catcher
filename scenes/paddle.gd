extends Area2D

@export var _speed: float = 400.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		self.position.x = maxf(0, self.position.x + -_speed * delta)
	elif Input.is_action_pressed("right"):
		self.position.x = minf(self.position.x + _speed * delta, get_viewport_rect().size.x)
