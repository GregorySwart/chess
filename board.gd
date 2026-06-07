extends TileMapLayer

const white_pawn_squares = ["a2", "b2", "c2", "d2", "e2", "f2", "g2", "h2"]
const black_pawn_squares = ["a7", "b7", "c7", "d7", "e7", "f7", "g7", "h7"]
const white_rook_squares = ["a1", "h1"]
const black_rook_squares = ["a8", "h8"]

const TILE_SIZE = 64

@export var move_indicator_scene: PackedScene
@export var white_pawn_scene: PackedScene
#@export var black_pawn_scene: PackedScene
#@export var white_rook_scene: PackedScene
#@export var black_rook_scene: PackedScene
# Keep track of all pieces in a dict to ensure only one piece sits on a square
@export var board_dict: Dictionary[String, Node] = {}
@export var move_indicators: Array[Node] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for square: String in white_pawn_squares:
		print("Creating white pawn at %s %s" % [square, str(Utils.to_coords(square))])
		var white_pawn: Node = white_pawn_scene.instantiate()
		white_pawn.position = Utils.to_coords(square)
		white_pawn.square_alg = square
		board_dict[square] = white_pawn
		add_child(white_pawn)

	# Comment out populating the rest of the board until scene and script hierarchy has been redone
	for square: String in black_pawn_squares:
		#print("Creating black pawn at " + square + ": " + str(Utils.to_coords(square)))
		#var black_pawn = black_pawn_scene.instantiate()
		#black_pawn.position = Utils.to_coords(square)
		#black_pawn.square_alg = square
		#add_child(black_pawn)
		pass
		
	for square: String in white_rook_squares:
		#print("Creating white rook at " + square + ": " + str(Utils.to_coords(square)))
		#var white_rook = white_rook_scene.instantiate()
		#white_rook.position = Utils.to_coords(square)
		#white_rook.square_alg = square
		#add_child(white_rook)
		pass
		
	for square: String in black_rook_squares:
		#print("Creating black rook at " + square + ": " + str(Utils.to_coords(square)))
		#var black_rook = black_rook_scene.instantiate()
		#black_rook.position = Utils.to_coords(square)
		#black_rook.square_alg = square
		#add_child(black_rook)
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Some print statements for debugging
	if Input.is_action_pressed("s"):
		var currently_selected_piece: Piece = get_selected_piece()
		if currently_selected_piece:
			print("Selected piece: %s (%s)" % [currently_selected_piece.type, currently_selected_piece])
			print("Piece.square_alg: %s" % currently_selected_piece.square_alg)
			print("Piece.position: %s" % currently_selected_piece.position)
			print("Potential moves: %s" % str(currently_selected_piece.get_moves()))
			
		else:
			print("No piece selected")
		print("Number of pieces on board: %s" % str(len(board_dict)))
		
		print("Board dictionary:")
		for k in board_dict:
			var v: Node = board_dict[k]
			print("%s: %s (%s)" % [k , v.type, v])

func fetch_piece_at_square(alg: String) -> Node:
	print("Fetching piece at %s..." % alg)
	var piece: Node = board_dict.get(alg)
	
	return piece

func get_selected_piece() -> Node:
	""" Return the currently selected piece - if no piece is selected, return null """
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
	""" Board is clicked """
	if event.is_action_pressed("left_click"):
		remove_move_indicators()
		
		var alg: String = Utils.to_alg(event.position)  # Clicked square (algebraic notation)
		print("Clicked board at %s which is identified as %s" % [event.position, alg])
		var previously_selected_piece: Node = get_selected_piece()
		var clicked_piece: Node = fetch_piece_at_square(alg)
		
		var previously_selected_piece_pos: String = previously_selected_piece.square_alg if previously_selected_piece else "<NONE>"
		var clicked_piece_pos: String = clicked_piece.square_alg if clicked_piece else "<NONE>"
		print("Previously selected piece: %s - clicked piece: %s" % [previously_selected_piece_pos, clicked_piece_pos])
		
		# TODO Tidy up these elifs
		if not clicked_piece and not previously_selected_piece:
			# Nothing happens - maybe add some logging
			pass
			
		elif not clicked_piece and previously_selected_piece:
			var potential_moves: Array[String] = previously_selected_piece.get_moves()
			if alg in potential_moves:
				var start_position: String = previously_selected_piece.square_alg
				previously_selected_piece.position = Utils.to_coords(alg)
				previously_selected_piece.square_alg = alg
				board_dict.erase(start_position)
				board_dict[alg] = previously_selected_piece
			previously_selected_piece.is_selected = false
		
		elif clicked_piece and not previously_selected_piece:
			clicked_piece.is_selected = true
			
			# TODO Render move indicators onto all squares the piece can move
			var potential_moves: Array[String] = clicked_piece.get_moves()
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
		
		else:  # clicked_piece and previously_selected_piece
			# TODO check if previously_selected_piece can capture clicked_piece
			previously_selected_piece.is_selected = false
			clicked_piece.is_selected = true

func _on_board_area_mouse_entered() -> void:
	pass
