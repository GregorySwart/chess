extends Piece
class_name WhitePawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = "White Pawn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)


func get_moves():
	var potential_moves: Array[String] = []
	
	var current_square: Vector2i = Utils.alg_to_board_coords(square_alg)
	
	var one_square_ahead: Vector2i = Vector2i(current_square.x, current_square.y + 1)
	var one_square_ahead_alg: String = Utils.board_coords_to_alg(one_square_ahead)
	potential_moves.append(one_square_ahead_alg)
	
	if current_square.y == 2:
		var two_squares_ahead: Vector2i = Vector2i(current_square.x, current_square.y + 2)
		var two_squares_ahead_alg: String = Utils.board_coords_to_alg(two_squares_ahead)
		potential_moves.append(two_squares_ahead_alg)
	
	return potential_moves
