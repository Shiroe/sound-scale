extends Node2D

@onready var hpElement = $PlayerHUD/PlayerStatsContainer/LifeContainer/LifeValue
@onready var highscoreElement = $PlayerHUD/PlayerStatsContainer/HighscoreContainer/HighscoreValue
@onready var audioPlayer = $AudioStreamPlayer
@onready var bgMusic = load("res://assets/notes/demo-sound-scale.wav") as AudioStreamWAV;
@onready var enemy: PackedScene = preload("res://scenes/enemy.tscn");
@onready var player = $Player
@onready var camera = $Camera2D
@onready var timer: Timer = Timer.new() as Timer;
@onready var spawnner = $Spawnner
@onready var spawnTimer: Timer = Timer.new() as Timer;
@onready var cursor = $CanvasLayer/Cursor
@onready var cursorTweener: Tween;

@export var spawnGCD: float = randf_range(0.1, 1.0);
@export var moveGCD: float = 0.2;
@export var BPM: float = 120.0;
@export var Measure: int = 4;
@export var BeatsInMeasure: int = 4;

var activeLaneIndex: int = 0;
var Lanes: Array[int] = [650, 600, 550, 500, 450, 400, 350, 300];
var positionOffset = 0;
var totalTrackTime: float = 1.0 * 60.0 * 5.0;

var audioStream: AudioStreamWAV;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.moveToLane(activeLaneIndex)
	self.add_child(spawnTimer);
	
	cursorTweener = create_tween();
	cursorTweener.bind_node(cursor);
	setupCursorAndTimer();
	
	audioStream = bgMusic
	audioPlayer.stream = audioStream;
	#audioPlayer.play();
	#audioPlayer.finished.connect(func(): audioPlayer.play());
	
	var totalMeasures = BPM / Measure;
	var MeasureDurationInSeconds = 60.0 / totalMeasures;
	var measureFractionInSeconds = MeasureDurationInSeconds / BeatsInMeasure;

	spawnTimer.start(measureFractionInSeconds);
	spawnTimer.timeout.connect(func():
		spawnEnemies();
		spawnTimer.start(measureFractionInSeconds);
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera.position = player.position;
	spawnner.position.x = player.position.x + get_viewport().size.x;
	setCursorPosition();
	highscoreElement.text = str(Game.CURRENT_SCORE);
	hpElement.text = str(Game.PLAYER_HP);


func spawnEnemies():
	var en = enemy.instantiate();
	var randIdx = randi_range(0, 7);
	en.laneIdx = randIdx;
	en.position.y = Lanes[randIdx] + positionOffset;
	en.position.x = spawnner.global_position.x;
	self.add_child(en);

func setCursorPosition():
	var percentage =  1 - (timer.time_left / totalTrackTime);
	var cursorPos = 10 + (1260 * percentage);
	if cursorTweener.is_running():
		cursorTweener.kill();
	cursorTweener = create_tween();
	cursorTweener.tween_property(cursor, 'position:x', cursorPos, 0.05).set_ease(Tween.EASE_IN);
	print('percentage: ', percentage);
	print('cursor pos:', cursorPos);
	print('actual pos:', cursor.global_position)

func setupCursorAndTimer():
	timer.wait_time = totalTrackTime;
	self.add_child(timer);
	timer.start();
	timer.timeout.connect(func(): endOfTrack());
	cursor.global_position.x = 10;

func endOfTrack():
	print('end of track!');
