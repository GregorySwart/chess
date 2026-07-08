extends Piece
class_name BlackPawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = "Black Pawn"
	colour = "black"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)

func get_moves(board_dict: Dictionary[String, Piece], last_move: Dictionary[String, Variant]) -> Array[String]:
	var potential_moves: Array[String] = []
	
	var current_square: Vector2i = Utils.alg_to_board_coords(square_alg)
	
	if current_square.y == 1:
		return potential_moves
	
	if current_square.y >= 1:
		var one_square_below: Vector2i = Vector2i(current_square.x, current_square.y - 1)
		var one_square_below_alg: String = Utils.board_coords_to_alg(one_square_below)
		if one_square_below_alg not in board_dict:
			potential_moves.append(one_square_below_alg)
	
	if current_square.y == 7:
		var two_squares_below: Vector2i = Vector2i(current_square.x, current_square.y - 2)
		var two_squares_below_alg: String = Utils.board_coords_to_alg(two_squares_below)
		var one_square_below: Vector2i = Vector2i(current_square.x, current_square.y - 1)
		var one_square_below_alg: String = Utils.board_coords_to_alg(one_square_below)
		if two_squares_below_alg not in board_dict and one_square_below_alg not in board_dict:
			potential_moves.append(two_squares_below_alg)
		
	# Check any captures
	# 1. Left
	if current_square.x > 1:
		var target_square: Vector2i = Vector2i(current_square.x - 1, current_square.y - 1)
		var target_square_alg: String = Utils.board_coords_to_alg(target_square)
		if target_square_alg in board_dict:
			var target_piece: Piece = board_dict[target_square_alg]
			if target_piece.colour != colour:
				potential_moves.append(target_square_alg)
	
	# 2. Right
	if current_square.x < 8:
		var target_square: Vector2i = Vector2i(current_square.x + 1, current_square.y - 1)
		var target_square_alg: String = Utils.board_coords_to_alg(target_square)
		if target_square_alg in board_dict:
			var target_piece: Piece = board_dict[target_square_alg]
			if target_piece.colour != colour:
				potential_moves.append(target_square_alg)

	# Check en passant conditions
	var last_move_piece: Piece = last_move["piece"]
	if last_move_piece:  # TODO Find a more elegant way of checking if this is not the first move
		# 1. Last move was made by an opposite-colour pawn
		var piece_matches: bool = last_move_piece.type == "White Pawn"
		# 2. Last move destination is horizontally adjacent to current square
		var destination_matches: bool = Utils.alg_to_board_coords(last_move["destination"])[1] == current_square[1]
		# 3. Last move origin is the pawn base rank (i.e. last move was a pawn double-move)
		var origin_matches: bool = Utils.alg_to_board_coords(last_move["origin"])[1] == 2
		# 4. The current piece is on the 5th rank
		var on_fourth_rank: bool = current_square[1] == 4
		
		if piece_matches and destination_matches and origin_matches and on_fourth_rank:
			var last_move_piece_file: int = Utils.alg_to_board_coords(last_move_piece.square_alg)[0]
			var target_square: Vector2i = Vector2i(last_move_piece_file, current_square.y - 1)
			var target_square_alg: String = Utils.board_coords_to_alg(target_square)
			potential_moves.append(target_square_alg)
	
	return potential_moves
