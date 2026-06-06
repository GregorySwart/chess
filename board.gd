extends TileMapLayer

const white_pawn_squares = ["a2", "b2", "c2", "d2", "e2", "f2", "g2", "h2"]
const black_pawn_squares = ["a7", "b7", "c7", "d7", "e7", "f7", "g7", "h7"]
const white_rook_squares = ["a1", "h1"]
const black_rook_squares = ["a8", "h8"]

const TILE_SIZE = 64

@export var white_pawn_scene: PackedScene
#@export var black_pawn_scene: PackedScene
#@export var white_rook_scene: PackedScene
#@export var black_rook_scene: PackedScene
@export var selected_piece: Node
@export var pieces_on_board: Array[RigidBody2D] = []
@export var board_dict: Dictionary = {}  # Keep track of all pieces in a dict to ensure only one piece sits on a square

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for square in white_pawn_squares:
		print("Creating white pawn at %s %s" % [square, str(Utils.to_coords(square))])
		var white_pawn = white_pawn_scene.instantiate()
		white_pawn.position = Utils.to_coords(square)
		white_pawn.square_alg = square
		board_dict[square] = white_pawn
		pieces_on_board.append(white_pawn)
		add_child(white_pawn)

	# Comment out populating the rest of the board until scene and script hierarchy has been redone
	for square in black_pawn_squares:
		#print("Creating black pawn at " + square + ": " + str(Utils.to_coords(square)))
		#var black_pawn = black_pawn_scene.instantiate()
		#black_pawn.position = Utils.to_coords(square)
		#black_pawn.square_alg = square
		#add_child(black_pawn)
		pass
		
	for square in white_rook_squares:
		#print("Creating white rook at " + square + ": " + str(Utils.to_coords(square)))
		#var white_rook = white_rook_scene.instantiate()
		#white_rook.position = Utils.to_coords(square)
		#white_rook.square_alg = square
		#add_child(white_rook)
		pass
		
	for square in black_rook_squares:
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
		if selected_piece:
			print("Selected piece: %s (%s)" % [selected_piece.type, selected_piece])
			print("Potential moves: %s" % str(selected_piece.get_moves()))
		else:
			print("No piece selected")
		print("Number of pieces on board: %s" % str(len(pieces_on_board)))
		
		print("Board dictionary:")
		for k in board_dict:
			var v = board_dict[k]
			print("%s: %s (%s)" % [k , v.type, v])

func fetch_piece_at_square(alg: String) :
	return board_dict.get(alg)


func _on_board_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		var alg: String = Utils.to_alg(event.position)
		print("Clicked board at %s which is identified as %s" % [event.position, alg])
		
		print("Fetching piece at %s...", alg)
		var piece = fetch_piece_at_square(alg)
		if piece:
			var previously_selected_piece = selected_piece
			if previously_selected_piece:
				previously_selected_piece.is_selected = false
			
			print("Identified piece at %s as %s" % [alg, str(piece)])
			
			selected_piece = piece
			piece.is_selected = true
		else:
			var previously_selected_piece = selected_piece
			if previously_selected_piece:
				previously_selected_piece.is_selected = false
			print("No piece found at %s" % alg)


func _on_board_area_mouse_entered() -> void:
	#print("Mouse entered board!")
	pass
