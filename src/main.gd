extends Node2D

@onready var audioPlayer = $AudioStreamPlayer
@onready var bgMusic = load("res://assets/notes/demo-sound-scale.wav") as AudioStreamWAV;


# Called when the node enters the scene tree for the first time.
func _ready():
	audioPlayer.stream = bgMusic;
	audioPlayer.play();
	audioPlayer.finished.connect(func(): audioPlayer.play());


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/level_prototype.tscn");


func _on_quit_btn_pressed():
	get_tree().quit();
