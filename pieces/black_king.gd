extends Piece
class_name BlackKing


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = "Black King"
	colour = "black"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)

func get_moves(board_dict: Dictionary[String, Piece]) -> Array[String]:
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

	if square_alg == "e8" and not has_moved:
		# Check eligibility for castling
		
		# 1. King's side
		if not board_dict.get("f8") and not board_dict.get("g8") and board_dict.get("h8"):
			var corner_piece: Piece = board_dict["h8"]
			if corner_piece.type == "Black Rook" and not corner_piece.has_moved:
				potential_moves.append("g8")

		# 2. Queen's side
		if board_dict.get("a8") and not board_dict.get("b8") and not board_dict.get("c8") and not board_dict.get("d8"):
			var corner_piece: Piece = board_dict["a8"]
			if corner_piece.type == "Black Rook" and not corner_piece.has_moved:
				potential_moves.append("c8")


	return potential_moves
