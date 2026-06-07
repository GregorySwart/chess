extends Piece
class_name BlackPawn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = "Black Pawn"
	colour = "black"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)

func get_moves() -> Array[String]:
	var potential_moves: Array[String] = []
	
	var current_square: Vector2i = Utils.alg_to_board_coords(square_alg)
	
	if current_square.y >= 1:
		var one_square_below: Vector2i = Vector2i(current_square.x, current_square.y - 1)
		var one_square_below_alg: String = Utils.board_coords_to_alg(one_square_below)
		potential_moves.append(one_square_below_alg)
	
	if current_square.y == 7:
		var two_squares_below: Vector2i = Vector2i(current_square.x, current_square.y - 2)
		var two_squares_below_alg: String = Utils.board_coords_to_alg(two_squares_below)
		potential_moves.append(two_squares_below_alg)
	
	return potential_moves
