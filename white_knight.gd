extends Piece
class_name WhiteKnight


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = "White Knight"
	colour = "white"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)

func get_moves(board_dict: Dictionary[String, Piece]) -> Array[String]:
	var potential_moves: Array[String] = []
	var current_square: Vector2i = Utils.alg_to_board_coords(square_alg)
	
	for displacement_vector: Vector2i in [
		Vector2i(2, 1), Vector2i(1, 2),
		Vector2i(-2, 1), Vector2i(1, -2),
		Vector2i(2, -1), Vector2i(-1, 2), 
		Vector2i(-2, -1), Vector2i(-1, -2),
	]:
		var target_square: Vector2i = current_square + displacement_vector
		if not (1 <= target_square.x and target_square.x <= 8 and 1 <= target_square.y and target_square.y <= 8):
			continue
		
		var target_square_alg: String = Utils.board_coords_to_alg(target_square)
		if target_square_alg not in board_dict:
			potential_moves.append(target_square_alg)
		else:  # target_square_alg in board_dict
			var other_piece: Piece = board_dict[target_square_alg]
			if other_piece.colour != colour:
				potential_moves.append(target_square_alg)
			continue  # instead of break since we're still checking all the other squares
	
	return potential_moves
