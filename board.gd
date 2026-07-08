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
@export var last_move_dict: Dictionary[String, Variant] = {"piece": null, "origin": null, "destination": null}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	turn = "white"
	board_setup()

func board_setup() -> void:
	## Place all pieces on the board for the initial position

	for square: String in WHITE_PAWN_SQUARES:
		Utils.spawn_piece(self, white_pawn_scene, square, board_dict)

	for square: String in BLACK_PAWN_SQUARES:
		Utils.spawn_piece(self, black_pawn_scene, square, board_dict)

	for square: String in WHITE_KNIGHT_SQUARES:
		Utils.spawn_piece(self, white_knight_scene, square, board_dict)

	for square: String in BLACK_KNIGHT_SQUARES:
		Utils.spawn_piece(self, black_knight_scene, square, board_dict)
	
	for square: String in WHITE_BISHOP_SQUARES:
		Utils.spawn_piece(self, white_bishop_scene, square, board_dict)

	for square: String in BLACK_BISHOP_SQUARES:
		Utils.spawn_piece(self, black_bishop_scene, square, board_dict)

	for square: String in WHITE_ROOK_SQUARES:
		Utils.spawn_piece(self, white_rook_scene, square, board_dict)

	for square: String in BLACK_ROOK_SQUARES:
		Utils.spawn_piece(self, black_rook_scene, square, board_dict)

	for square: String in WHITE_QUEEN_SQUARES:
		Utils.spawn_piece(self, white_queen_scene, square, board_dict)

	for square: String in BLACK_QUEEN_SQUARES:
		Utils.spawn_piece(self, black_queen_scene, square, board_dict)

	for square: String in WHITE_KING_SQUARES:
		Utils.spawn_piece(self, white_king_scene, square, board_dict)

	for square: String in BLACK_KING_SQUARES:
		Utils.spawn_piece(self, black_king_scene, square, board_dict)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Some print statements for debugging
	if Input.is_action_pressed("s"):
		var currently_selected_piece: Piece = get_selected_piece()
		if currently_selected_piece:
			print("Selected piece: %s (%s)" % [currently_selected_piece.type, currently_selected_piece])
			print("Piece.square_alg: %s" % currently_selected_piece.square_alg)
			print("Piece.position: %s" % currently_selected_piece.position)
			print("Potential moves: %s" % str(currently_selected_piece.get_moves(board_dict, last_move_dict)))
			
		else:
			print("No piece selected")
		print("Number of pieces on board: %s" % str(len(board_dict)))
		
		print("Board dictionary:")
		for k in board_dict:
			var v: Piece = board_dict[k]
			print("%s: %s (%s)" % [k , v.type, v])
	
	if Input.is_action_pressed("m"):
		var currently_selected_piece: Piece = get_selected_piece()
		if currently_selected_piece:
			print("Potential moves: %s" % str(currently_selected_piece.get_moves(board_dict, last_move_dict)))
			
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

func get_selected_piece() -> Piece:
	## Return the currently selected piece - if no piece is selected, return null
	print("Checking for any selected pieces...")
	for square in board_dict:
		var piece: Piece = board_dict[square]
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

func select_piece(piece: Piece) -> void:
	piece.is_selected = true

func deselect_piece(piece: Piece) -> void:
	if piece:
		piece.is_selected = false

func check_castling(piece: Piece, destination_alg: String) -> void:
	if piece.type == "White King" and destination_alg == "g1":
		var rook: Piece = board_dict["h1"]
		rook.position = Utils.alg_to_pixel_coords("f1")
		rook.square_alg = "f1"
		rook.has_moved = true
		board_dict.erase("h1")
		board_dict["f1"] = rook
	elif piece.type == "White King" and destination_alg == "c1":
		var rook: Piece = board_dict["a1"]
		rook.position = Utils.alg_to_pixel_coords("d1")
		rook.square_alg = "d1"
		rook.has_moved = true
		board_dict.erase("a1")
		board_dict["d1"] = rook
	elif piece.type == "Black King" and destination_alg == "g8":
		var rook: Piece = board_dict["h8"]
		rook.position = Utils.alg_to_pixel_coords("f8")
		rook.square_alg = "f8"
		rook.has_moved = true
		board_dict.erase("h8")
		board_dict["f8"] = rook
	elif piece.type == "Black King" and destination_alg == "c8":
		var rook: Piece = board_dict["a8"]
		rook.position = Utils.alg_to_pixel_coords("d8")
		rook.square_alg = "d8"
		rook.has_moved = true
		board_dict.erase("a8")
		board_dict["d8"] = rook


func move_piece(piece: Piece, destination_alg: String) -> void:
	var start_position: String = piece.square_alg
	piece.position = Utils.alg_to_pixel_coords(destination_alg)
	piece.square_alg = destination_alg
	piece.has_moved = true
	board_dict.erase(start_position)
	board_dict[destination_alg] = piece
	last_move_dict = {"piece": piece, "origin": start_position, "destination": destination_alg}

	check_castling(piece, destination_alg)

	turn = Utils.update_turn(turn)
	$"Piece Moved".play()

func capture_piece(attacker: Piece, defender: Piece) -> void:
	var start_position: String = attacker.square_alg
	var destination_alg: String = defender.square_alg
	attacker.position = defender.position
	attacker.square_alg = destination_alg
	board_dict.erase(start_position)
	board_dict[destination_alg] = attacker
	last_move_dict = {"piece": attacker, "origin": start_position, "destination": destination_alg}

	turn = Utils.update_turn(turn)
	deselect_piece(attacker)
	defender.queue_free()
	$"Piece Captured".play()

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
			
			var potential_moves: Array[String] = previously_selected_piece.get_moves(board_dict, last_move_dict)
			if alg in potential_moves:
				# TODO Check en passant logic here!
				move_piece(previously_selected_piece, alg)
			deselect_piece(previously_selected_piece)
		
		elif clicked_piece and not previously_selected_piece:
			# There is no piece already selected and the user clicks on a piece -> Select the piece
			
			if clicked_piece.colour != turn:
				return
			
			select_piece(clicked_piece)
			
			var potential_moves: Array[String] = clicked_piece.get_moves(board_dict, last_move_dict)
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
				deselect_piece(previously_selected_piece)
				return
			
			if clicked_piece.colour == turn:
				deselect_piece(previously_selected_piece)
				select_piece(clicked_piece)
				return
			
			if clicked_piece.colour != turn:
				var potential_moves: Array[String] = previously_selected_piece.get_moves(board_dict, last_move_dict)
				if clicked_piece.square_alg in potential_moves:
					capture_piece(previously_selected_piece, clicked_piece)
				else:
					deselect_piece(previously_selected_piece)
					deselect_piece(clicked_piece)
		
		else:
			print("UNHANDLED CLICK!!!")
