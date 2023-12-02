extends Node


const DEFAULT_HP: int = 5;
const DEFAULT_SCORE: int = 0;


var PLAYER_HP = DEFAULT_HP;
var CURRENT_SCORE = DEFAULT_SCORE;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func resetLevel():
	PLAYER_HP = DEFAULT_HP;
	CURRENT_SCORE = DEFAULT_SCORE;
	
