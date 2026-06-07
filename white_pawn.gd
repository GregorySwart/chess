extends Piece
class_name WhitePawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = "White Pawn"
	colour = "white"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)

func get_moves(board_dict: Dictionary[String, Piece]) -> Array[String]:
	var potential_moves: Array[String] = []
	
	var current_square: Vector2i = Utils.alg_to_board_coords(square_alg)
	
	if current_square.y == 8:
		return potential_moves
	
	if current_square.y <= 7:
		var one_square_ahead: Vector2i = Vector2i(current_square.x, current_square.y + 1)
		var one_square_ahead_alg: String = Utils.board_coords_to_alg(one_square_ahead)
		potential_moves.append(one_square_ahead_alg)
	
	if current_square.y == 2:
		var two_squares_ahead: Vector2i = Vector2i(current_square.x, current_square.y + 2)
		var two_squares_ahead_alg: String = Utils.board_coords_to_alg(two_squares_ahead)
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
	
	return potential_moves
