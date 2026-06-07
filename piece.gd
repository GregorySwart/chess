extends RigidBody2D
class_name Piece

@export var type: String
@export var square_alg: String
@export var is_selected: bool = false
@export var colour: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Selection Box".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not is_selected:
		$"Selection Box".hide()
	else:
		$"Selection Box".show()
