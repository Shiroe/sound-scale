extends Node


const DEFAULT_HP: int = 5;
const DEFAULT_SCORE: int = 0;


var PLAYER_HP = DEFAULT_HP;
var CURRENT_SCORE = DEFAULT_SCORE;

var LANES: Array[int] = [670, 610, 550, 490, 430, 370, 310, 250];


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func increaseScore(noteValue: int) -> void:
	CURRENT_SCORE += noteValue;


func resetLevel():
	PLAYER_HP = DEFAULT_HP;
	CURRENT_SCORE = DEFAULT_SCORE;

func decreasePlayerHP() -> void:
	if (PLAYER_HP > 0):
		PLAYER_HP -= 1;
		if PLAYER_HP <= 0:
			get_tree().change_scene_to_file("res://scenes/main.tscn");
