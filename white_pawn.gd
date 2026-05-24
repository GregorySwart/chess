extends Piece
class_name WhitePawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = "White Pawn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)


func get_moves():
	pass
