extends Piece
class_name WhiteKnight


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = "White Knight"
	colour = "white"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)

func get_moves(_board_dict: Dictionary[String, Piece]) -> Array[String]:
	# TODO Implement move logic
	var _potential_moves: Array[String] = []
	var _current_square: Vector2i = Utils.alg_to_board_coords(square_alg)
	
	return []
