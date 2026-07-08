extends Piece
class_name WhiteKing


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = "White King"
	colour = "white"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)

func get_moves(board_dict: Dictionary[String, Piece], last_move: Dictionary[String, Variant]) -> Array[String]:
	var potential_moves: Array[String] = []
	var current_square: Vector2i = Utils.alg_to_board_coords(square_alg)
	
	for displacement_vector: Vector2i in [
		Vector2i(1, 0), Vector2i(-1, 0), Vector2i(0, 1), Vector2i(0, -1),  # Horizontal + vertical
		Vector2i(1, 1), Vector2i(1, -1), Vector2i(-1, 1), Vector2i(-1, -1),  # Diagonal
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
	
	if square_alg == "e1" and not has_moved:
		# Check eligibility for castling
		
		# 1. King's side
		if not board_dict.get("f1") and not board_dict.get("g1") and board_dict.get("h1"):
			var corner_piece: Piece = board_dict["h1"]
			if corner_piece.type == "White Rook" and not corner_piece.has_moved:
				potential_moves.append("g1")

		# 2. Queen's side
		if board_dict.get("a1") and not board_dict.get("b1") and not board_dict.get("c1") and not board_dict.get("d1"):
			var corner_piece: Piece = board_dict["a1"]
			if corner_piece.type == "White Rook" and not corner_piece.has_moved:
				potential_moves.append("c1")


	return potential_moves
