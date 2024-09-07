extends Node2D

const EXPLODE = preload("res://assets/explode.wav")

@export var gem_scene : PackedScene

@onready var score_label : Label = $Label
@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var game_over_label: Label = $Label2
@onready var try_again_button: TextureButton = $TextureButton

var _score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_label.hide()
	try_again_button.hide()
	spawn_gem()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func spawn_gem() -> void:
	var new_gem: Gem = gem_scene.instantiate()
	new_gem.on_gem_offscreen.connect(game_over)
	var xpos = randf_range(50, get_viewport_rect().size.x - 50)
	new_gem.position = Vector2(xpos, -50)
	add_child(new_gem)

func play_dead() -> void:
	audio_stream_player_2d.stop()
	audio_stream_player_2d.stream = EXPLODE
	audio_stream_player_2d.position.x = get_viewport_rect().position.x/2
	audio_stream_player_2d.play()

func stop_all() -> void:
	timer.stop()
	for child in get_children():
		child.set_process(false)
	
func game_over() -> void:
	game_over_label.show()
	try_again_button.show()
	try_again_button.z_index =  RenderingServer.CANVAS_ITEM_Z_MAX
	play_dead()
	stop_all()

func _on_timer_timeout() -> void:
	spawn_gem()


func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 100
	score_label.text = str(_score).lpad(5,"0")
	audio_stream_player_2d.position = area.position
	audio_stream_player_2d.play()
	area.queue_free()
