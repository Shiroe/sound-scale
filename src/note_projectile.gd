extends Area2D

@onready var audioPlayer = $AudioStreamPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = Timer.new() as Timer;

@export var SPEED = 645

var COLORS = [
	Vector4(1.0, 0.0, 0.0, 1.0), # red - Do
	Vector4(1.0, 0.5, 0.0, 1.0), # orange - Re
	Vector4(1.0, 1.0, 0.0, 1.0), # yellow - Mi
	Vector4(0.0, 1.0, 0.0, 1.0), # green - Fa
	Vector4(0.0, 1.0, 1.0, 1.0), # lightblue - Sol
	Vector4(0.0, 0.0, 1.0, 1.0), # blue - La
	Vector4(0.5, 0.0, 1.0, 1.0), # purple - Si
	Vector4(1.0, 0.0, 0.0, 0.7), # red - Do
]

var noteIndex = 0;
var audioStream: AudioStreamWAV;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audioPlayer.stream = audioStream;
	audioPlayer.play();

	self.add_child(timer);
	timer.start(audioStream.get_length())
	timer.timeout.connect(func(): queue_free());
	
	sprite.material.set_shader_parameter('line_color', COLORS[noteIndex]);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x +=  950 / 0.5 * delta;
	


func _on_area_entered(area: Area2D) -> void:
	#print('hit a target', area.is_in_group('enemies'))
	if area.is_in_group('enemies'):
		area.queue_free();
		Game.increaseScore(noteIndex+1);
