extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D;

#var material = 

var laneIdx = 0;

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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_to_group('enemies');
	sprite.material.set_shader_parameter('line_color', COLORS[laneIdx]);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body):
	if (body.name == "Player"):
		body.takeDamage();
