extends Node2D

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

var activeLaneIndex: int = 0;
var Lanes: Array[int] = [650, 600, 550, 500, 450, 400, 350, 300];
var positionOffset = 0;
var totalTrackTime: float = 1.0 * 60.0 * 5.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.moveToLane(activeLaneIndex)
	self.add_child(spawnTimer);
	
	cursorTweener = create_tween();
	cursorTweener.bind_node(cursor);
	setupCursorAndTimer();

	spawnTimer.start(randf_range(0.5, 1.0));
	spawnTimer.timeout.connect(func():
		spawnEnemies();
		spawnTimer.start(randf_range(0.75, 1.0));
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera.position = player.position;
	spawnner.position.x = player.position.x + get_viewport().size.x;
	setCursorPosition();


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
