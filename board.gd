extends TileMapLayer

const WHITE_PAWN_SQUARES = ["a2", "b2", "c2", "d2", "e2", "f2", "g2", "h2"]
const BLACK_PAWN_SQUARES = ["a7", "b7", "c7", "d7", "e7", "f7", "g7", "h7"]
const WHITE_KNIGHT_SQUARES = ["b1", "g1"]
const BLACK_KNIGHT_SQUARES = ["b8", "g8"]
const WHITE_BISHOP_SQUARES = ["c1", "f1"]
const BLACK_BISHOP_SQUARES = ["c8", "f8"]
const WHITE_ROOK_SQUARES = ["a1", "h1"]
const BLACK_ROOK_SQUARES = ["a8", "h8"]
const WHITE_QUEEN_SQUARES = ["d1"]
const BLACK_QUEEN_SQUARES = ["d8"]
const WHITE_KING_SQUARES = ["e1"]
const BLACK_KING_SQUARES = ["e8"]

@export var move_indicator_scene: PackedScene
@export var white_pawn_scene: PackedScene
@export var black_pawn_scene: PackedScene
@export var white_knight_scene: PackedScene
@export var black_knight_scene: PackedScene
@export var white_bishop_scene: PackedScene
@export var black_bishop_scene: PackedScene
@export var white_rook_scene: PackedScene
@export var black_rook_scene: PackedScene
@export var white_queen_scene: PackedScene
@export var black_queen_scene: PackedScene
@export var white_king_scene: PackedScene
@export var black_king_scene: PackedScene

# Keep track of all pieces in a dict to ensure only one piece sits on a square
@export var board_dict: Dictionary[String, Piece] = {}
@export var move_indicators: Array[MoveIndicator] = []  # NOTE Move indicators are bugged - disabled for now
@export var turn: String  # Whose turn is it?

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	turn = "white"
	
	# TODO Figure out a way to factor this out into a util fn - can Utils import the piece scenes?
	# Can I just declare the piece scenes as export vars in Utils too?
	
	for square: String in WHITE_PAWN_SQUARES:
		print("Creating white pawn at %s %s" % [square, str(Utils.alg_to_pixel_coords(square))])
		var white_pawn: Piece = white_pawn_scene.instantiate()
		white_pawn.position = Utils.alg_to_pixel_coords(square)
		white_pawn.square_alg = square
		board_dict[square] = white_pawn
		add_child(white_pawn)

	for square: String in BLACK_PAWN_SQUARES:
		print("Creating black pawn at %s %s" % [square, str(Utils.alg_to_pixel_coords(square))])
		var black_pawn: Piece = black_pawn_scene.instantiate()
		black_pawn.position = Utils.alg_to_pixel_coords(square)
		black_pawn.square_alg = square
		board_dict[square] = black_pawn
		add_child(black_pawn)
		
	for square: String in WHITE_KNIGHT_SQUARES:
		print("Creating white knight at %s %s" % [square, str(Utils.alg_to_pixel_coords(square))])
		var white_knight: Piece = white_knight_scene.instantiate()
		white_knight.position = Utils.alg_to_pixel_coords(square)
		white_knight.square_alg = square
		board_dict[square] = white_knight
		add_child(white_knight)

	for square: String in BLACK_KNIGHT_SQUARES:
		print("Creating black knight at %s %s" % [square, str(Utils.alg_to_pixel_coords(square))])
		var black_knight: Piece = black_knight_scene.instantiate()
		black_knight.position = Utils.alg_to_pixel_coords(square)
		black_knight.square_alg = square
		board_dict[square] = black_knight
		add_child(black_knight)
		
	for square: String in WHITE_BISHOP_SQUARES:
		print("Creating white bishop at %s %s" % [square, str(Utils.alg_to_pixel_coords(square))])
		var white_bishop: Piece = white_bishop_scene.instantiate()
		white_bishop.position = Utils.alg_to_pixel_coords(square)
		white_bishop.square_alg = square
		board_dict[square] = white_bishop
		add_child(white_bishop)

	for square: String in BLACK_BISHOP_SQUARES:
		print("Creating black bishop at %s %s" % [square, str(Utils.alg_to_pixel_coords(square))])
		var black_bishop: Piece = black_bishop_scene.instantiate()
		black_bishop.position = Utils.alg_to_pixel_coords(square)
		black_bishop.square_alg = square
		board_dict[square] = black_bishop
		add_child(black_bishop)
		
	for square: String in WHITE_ROOK_SQUARES:
		print("Creating white rook at %s %s" % [square, str(Utils.alg_to_pixel_coords(square))])
		var white_rook: Piece = white_rook_scene.instantiate()
		white_rook.position = Utils.alg_to_pixel_coords(square)
		white_rook.square_alg = square
		board_dict[square] = white_rook
		add_child(white_rook)

	for square: String in BLACK_ROOK_SQUARES:
		print("Creating black rook at %s %s" % [square, str(Utils.alg_to_pixel_coords(square))])
		var black_rook: Piece = black_rook_scene.instantiate()
		black_rook.position = Utils.alg_to_pixel_coords(square)
		black_rook.square_alg = square
		board_dict[square] = black_rook
		add_child(black_rook)
		
	for square: String in WHITE_QUEEN_SQUARES:
		print("Creating white queen at %s %s" % [square, str(Utils.alg_to_pixel_coords(square))])
		var white_queen: Piece = white_queen_scene.instantiate()
		white_queen.position = Utils.alg_to_pixel_coords(square)
		white_queen.square_alg = square
		board_dict[square] = white_queen
		add_child(white_queen)

	for square: String in BLACK_QUEEN_SQUARES:
		print("Creating black queen at %s %s" % [square, str(Utils.alg_to_pixel_coords(square))])
		var black_queen: Piece = black_queen_scene.instantiate()
		black_queen.position = Utils.alg_to_pixel_coords(square)
		black_queen.square_alg = square
		board_dict[square] = black_queen
		add_child(black_queen)
		
	for square: String in WHITE_KING_SQUARES:
		print("Creating white king at %s %s" % [square, str(Utils.alg_to_pixel_coords(square))])
		var white_king: Piece = white_king_scene.instantiate()
		white_king.position = Utils.alg_to_pixel_coords(square)
		white_king.square_alg = square
		board_dict[square] = white_king
		add_child(white_king)

	for square: String in BLACK_KING_SQUARES:
		print("Creating black king at %s %s" % [square, str(Utils.alg_to_pixel_coords(square))])
		var black_king: Piece = black_king_scene.instantiate()
		black_king.position = Utils.alg_to_pixel_coords(square)
		black_king.square_alg = square
		board_dict[square] = black_king
		add_child(black_king)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Some print statements for debugging
	if Input.is_action_pressed("s"):
		var currently_selected_piece: Piece = get_selected_piece()
		if currently_selected_piece:
			print("Selected piece: %s (%s)" % [currently_selected_piece.type, currently_selected_piece])
			print("Piece.square_alg: %s" % currently_selected_piece.square_alg)
			print("Piece.position: %s" % currently_selected_piece.position)
			print("Potential moves: %s" % str(currently_selected_piece.get_moves(board_dict)))
			
		else:
			print("No piece selected")
		print("Number of pieces on board: %s" % str(len(board_dict)))
		
		print("Board dictionary:")
		for k in board_dict:
			var v: Node = board_dict[k]
			print("%s: %s (%s)" % [k , v.type, v])
	
	if Input.is_action_pressed("m"):
		var currently_selected_piece: Piece = get_selected_piece()
		if currently_selected_piece:
			print("Potential moves: %s" % str(currently_selected_piece.get_moves(board_dict)))
			
	if Input.is_action_pressed("b"):
		print("Total pieces in board_dict: %d" % len(board_dict))
		for k: String in board_dict.keys():
			var v: Piece = board_dict[k]
			if is_instance_valid(v):
				print("%s: %s" % [k, str(v.type)])
			else:
				print("Found invalid instance at %s!" % k)

func fetch_piece_at_square(alg: String) -> Piece:
	print("Fetching piece at %s..." % alg)
	var piece: Piece = board_dict.get(alg)

	return piece

func get_selected_piece() -> Node:
	## Return the currently selected piece - if no piece is selected, return null
	print("Checking for any selected pieces...")
	for square in board_dict:
		var piece: Node = board_dict[square]
		if piece.is_selected:
			print("Found selected piece %s at %s" % [piece, square])
			return piece
	
	print("No selected pieces found on the board - checked %s" % str(board_dict.keys()))
	return null

func remove_move_indicators() -> void:
	print("Removing all move indicators...")
	for move_indicator in move_indicators:
		print("Removing move indicator at %s" % move_indicator.square_alg)
		move_indicator.queue_free()
	move_indicators = []

func _on_board_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	## Board is clicked
	if event.is_action_pressed("left_click"):
		remove_move_indicators()
		
		var alg: String = Utils.pixel_coords_to_alg(event.position)  # Clicked square (algebraic notation)
		print("Clicked board at %s which is identified as %s" % [event.position, alg])
		var previously_selected_piece: Piece = get_selected_piece()
		var clicked_piece: Piece = fetch_piece_at_square(alg)
		
		var previously_selected_piece_pos: String = previously_selected_piece.square_alg \
			if previously_selected_piece else "<NONE>"
		var clicked_piece_pos: String = clicked_piece.square_alg if clicked_piece else "<NONE>"
		print("Previously selected piece: %s - clicked piece: %s" % [previously_selected_piece_pos, clicked_piece_pos])
		
		# TODO Tidy up these elifs
		if not clicked_piece and not previously_selected_piece:
			# Nothing happens - maybe add some logging
			pass
			
		elif not clicked_piece and previously_selected_piece:
			# A piece is already selected and the user clicks on an empty square -> Move or deselect
			
			var potential_moves: Array[String] = previously_selected_piece.get_moves(board_dict)
			if alg in potential_moves:
				var start_position: String = previously_selected_piece.square_alg
				previously_selected_piece.position = Utils.alg_to_pixel_coords(alg)
				previously_selected_piece.square_alg = alg
				board_dict.erase(start_position)
				board_dict[alg] = previously_selected_piece
				turn = Utils.update_turn(turn)
				$"Piece Moved".play()
			previously_selected_piece.is_selected = false
		
		elif clicked_piece and not previously_selected_piece:
			# There is no piece already selected and the user clicks on a piece -> Select the piece
			
			if clicked_piece.colour == turn:
				clicked_piece.is_selected = true
			
			var potential_moves: Array[String] = clicked_piece.get_moves(board_dict)
			for potential_move in potential_moves:
				# TODO Fix the below move indicator logic - bugs out for some reason
				
				# BUG When move indicators are rendered other pieces are rendered at their starting position, while
				# retaining their correct `piece.position`
				
				#print("Rendering move indicator at %s %s" % [potential_move, str(Utils.to_coords(potential_move))])
				#var move_indicator: Node = move_indicator_scene.instantiate()
				#move_indicator.position = Utils.to_coords(potential_move)
				#move_indicator.square_alg = potential_move
				#add_child(move_indicator)
				#move_indicators.append(move_indicator)
				pass
		
		elif clicked_piece and previously_selected_piece:
			# A piece is already selected and the user clicks on another piece -> Cap or deselect
			
			if clicked_piece == previously_selected_piece:
				previously_selected_piece.is_selected = false
				clicked_piece.is_selected = false
				return
				
			if clicked_piece.colour == turn:
				previously_selected_piece.is_selected = false
				clicked_piece.is_selected = true
			
			elif clicked_piece.colour != turn:
				var potential_moves: Array[String] = previously_selected_piece.get_moves(board_dict)
				
				if clicked_piece.square_alg in potential_moves:
					previously_selected_piece.is_selected = false
					clicked_piece.is_selected = false
					
					board_dict.erase(previously_selected_piece.square_alg)
					board_dict[clicked_piece.square_alg] = previously_selected_piece
					previously_selected_piece.position = clicked_piece.position
					previously_selected_piece.square_alg = clicked_piece.square_alg
					turn = Utils.update_turn(turn)
					clicked_piece.queue_free()
					$"Piece Captured".play()
				else:
					previously_selected_piece.is_selected = false
					clicked_piece.is_selected = false
		
		else:
			print("UNHANDLED CLICK!!!")

func _on_board_area_mouse_entered() -> void:
	pass
