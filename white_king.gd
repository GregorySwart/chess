extends Piece
class_name WhiteKing


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = "White King"
	colour = "white"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)

func get_moves(_board_dict: Dictionary[String, Piece]) -> Array[String]:
	var potential_moves: Array[String] = []
	var current_square: Vector2i = Utils.alg_to_board_coords(square_alg)
	
	for displacement_vector: Vector2i in [
		Vector2i(1, 0), Vector2i(-1, 0), Vector2i(0, 1), Vector2i(0, -1),  # Horizontal + vertical
		Vector2i(1, 1), Vector2i(1, -1), Vector2i(-1, 1), Vector2i(-1, -1),  # Diagonal
	]:
		var target_square: Vector2i = current_square + displacement_vector
		if 1 <= target_square.x and target_square.x <= 8 and 1 <= target_square.y and target_square.y <= 8:
			var target_square_alg: String = Utils.board_coords_to_alg(target_square)
			potential_moves.append(target_square_alg)
		
	return potential_moves
