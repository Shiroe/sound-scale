extends CharacterBody2D

@onready var C4 = load("res://assets/notes/tone-c4.wav") as AudioStreamWAV;
@onready var D4 = load("res://assets/notes/tone-d4.wav") as AudioStreamWAV;
@onready var E4 = load("res://assets/notes/tone-e4.wav") as AudioStreamWAV;
@onready var F4 = load("res://assets/notes/tone-f4.wav") as AudioStreamWAV;
@onready var G4 = load("res://assets/notes/tone-g4.wav") as AudioStreamWAV;
@onready var A4 = load("res://assets/notes/tone-a4.wav") as AudioStreamWAV;
@onready var B4 = load("res://assets/notes/tone-b4.wav") as AudioStreamWAV;
@onready var C5 = load("res://assets/notes/tone-c5.wav") as AudioStreamWAV;

@onready var muzzle = $Marker2D
@onready var timer = $Timer
@onready var animation = $AnimatedSprite2D
@onready var tweener: Tween
@onready var projectileNote: PackedScene = preload("res://scenes/note_projectile.tscn");
@onready var moveTimer: Timer = Timer.new() as Timer; 
@onready var invisCD: Timer = Timer.new() as Timer;

@export var moveGCD: float = 0.05;

var activeLaneIndex: int = 0;
var positionOffset = 0;

@export var SPEED = 200.0
#const JUMP_VELOCITY = -20.0


func _ready() -> void:
	tweener = create_tween()
	tweener.bind_node(self);
	self.add_child(moveTimer);
	invisCD.one_shot = true;
	self.add_child(invisCD);
	

func _process(delta: float) -> void:
	velocity.x = 950 / 4;
	if velocity.x > 0 and not animation.is_playing():
		animation.play("walking");
	elif velocity.y < 0:
		animation.play("jumping");
	else:
		pass #animation.play("default");
	
	if Input.is_action_just_pressed("key_one"):
		if activeLaneIndex != 0:
			moveToLane(0);
			tweener.finished.connect(func(): shoot(activeLaneIndex));
		else:
			shoot(0);
	if Input.is_action_just_pressed("key_two"):
		if activeLaneIndex != 1:
			moveToLane(1);
			tweener.finished.connect(func(): shoot(activeLaneIndex));
		else:
			shoot(1);
	if Input.is_action_just_pressed("key_three"):
		if activeLaneIndex != 2:
			moveToLane(2);
			tweener.finished.connect(func(): shoot(activeLaneIndex));
		else:
			shoot(2);
	if Input.is_action_just_pressed("key_four"):
		if activeLaneIndex != 3:
			moveToLane(3);
			tweener.finished.connect(func(): shoot(activeLaneIndex));
		else:
			shoot(3);
	if Input.is_action_just_pressed("key_five"):
		if activeLaneIndex != 4:
			moveToLane(4);
			tweener.finished.connect(func(): shoot(activeLaneIndex));
		else:
			shoot(4);
	if Input.is_action_just_pressed("key_six"):
		if activeLaneIndex != 5:
			moveToLane(5);
			tweener.finished.connect(func(): shoot(activeLaneIndex));
		else:
			shoot(5);
	if Input.is_action_just_pressed("key_seven"):
		if activeLaneIndex != 6:
			moveToLane(6);
			tweener.finished.connect(func(): shoot(activeLaneIndex));
		else:
			shoot(6);
	if Input.is_action_just_pressed("key_eight"):
		if activeLaneIndex != 7:
			moveToLane(7);
			tweener.finished.connect(func(): shoot(activeLaneIndex));
		else:
			shoot(7);
		
	
	move_and_slide()

func moveToLane(idx: int):
	activeLaneIndex = idx;
	setPosition(Vector2(self.position.x, Game.LANES[activeLaneIndex] + positionOffset));
	moveTimer.start(moveGCD);

func shoot(key: int):
	animation.play("attack");
	var chords = [C4, D4, E4, F4, G4, A4, B4, C5];
	var projectile = projectileNote.instantiate();
	projectile.noteIndex = key;
	projectile.audioStream = chords[key];
	projectile.transform = muzzle.global_transform
	owner.add_child(projectile);

func setPosition(pos: Vector2):
	if tweener.is_running():
		tweener.kill();
	tweener = create_tween();
	tweener.tween_property(self, 'position:y', pos.y, 0.05).set_ease(Tween.EASE_IN);
	
func takeDamage() -> void:
	if invisCD.is_stopped():
		invisCD.start(0.5); 
		animation.play("hurt");
		Game.decreasePlayerHP();

