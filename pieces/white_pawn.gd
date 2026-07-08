extends Piece
class_name WhitePawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = "White Pawn"
	colour = "white"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)

func get_moves(board_dict: Dictionary[String, Piece], last_move: Dictionary[String, Variant]) -> Array[String]:
	var potential_moves: Array[String] = []
	
	var current_square: Vector2i = Utils.alg_to_board_coords(square_alg)
	
	if current_square.y == 8:
		return potential_moves
	
	if current_square.y <= 7:
		var one_square_ahead: Vector2i = Vector2i(current_square.x, current_square.y + 1)
		var one_square_ahead_alg: String = Utils.board_coords_to_alg(one_square_ahead)
		if one_square_ahead_alg not in board_dict:
			potential_moves.append(one_square_ahead_alg)
	
	if current_square.y == 2:
		var one_square_ahead: Vector2i = Vector2i(current_square.x, current_square.y + 1)
		var one_square_ahead_alg: String = Utils.board_coords_to_alg(one_square_ahead)
		var two_squares_ahead: Vector2i = Vector2i(current_square.x, current_square.y + 2)
		var two_squares_ahead_alg: String = Utils.board_coords_to_alg(two_squares_ahead)
		if two_squares_ahead_alg not in board_dict and one_square_ahead_alg not in board_dict:
			potential_moves.append(two_squares_ahead_alg)
		
	# Check any captures
	# 1. Left
	if current_square.x > 1:
		var target_square: Vector2i = Vector2i(current_square.x - 1, current_square.y + 1)
		var target_square_alg: String = Utils.board_coords_to_alg(target_square)
		if target_square_alg in board_dict:
			var target_piece: Piece = board_dict[target_square_alg]
			if target_piece.colour != colour:
				potential_moves.append(target_square_alg)
	
	# 2. Right
	if current_square.x < 8:
		var target_square: Vector2i = Vector2i(current_square.x + 1, current_square.y + 1)
		var target_square_alg: String = Utils.board_coords_to_alg(target_square)
		if target_square_alg in board_dict:
			var target_piece: Piece = board_dict[target_square_alg]
			if target_piece.colour != colour:
				potential_moves.append(target_square_alg)
	
	# Check en passant conditions
	var last_move_piece: Piece = last_move["piece"]
	if last_move_piece:  # TODO Find a more elegant way of checking if this is not the first move
		# 1. Last move was made by an opposite-colour pawn
		var piece_matches: bool = last_move_piece.type == "Black Pawn"
		# 2. Last move destination is horizontally adjacent to current square
		var destination_matches: bool = Utils.alg_to_board_coords(last_move["destination"])[1] == current_square[1]
		# 3. Last move origin is the pawn base rank (i.e. last move was a pawn double-move)
		var origin_matches: bool = Utils.alg_to_board_coords(last_move["origin"])[1] == 7
		
		if piece_matches and destination_matches and origin_matches:
			var target_square: Vector2i = Vector2i(current_square.x + 1, current_square.y + 1)
			var target_square_alg: String = Utils.board_coords_to_alg(target_square)
			potential_moves.append(target_square_alg)
	
	return potential_moves
