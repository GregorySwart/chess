extends TileMapLayer


const white_pawn_squares = ["a2", "b2", "c2", "d2", "e2", "f2", "g2", "h2"]
const black_pawn_squares = ["a7", "b7", "c7", "d7", "e7", "f7", "g7", "h7"]
const white_rook_squares = ["a1", "h1"]
const black_rook_squares = ["a8", "h8"]


const TILE_SIZE = 64


@export var white_pawn_scene: PackedScene
@export var black_pawn_scene: PackedScene
@export var white_rook_scene: PackedScene
@export var black_rook_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for square in white_pawn_squares:
		print("Creating white pawn at " + square + ": " + str(to_coords(square)))
		var white_pawn = white_pawn_scene.instantiate()
		white_pawn.position = to_coords(square)
		add_child(white_pawn)
		
	for square in black_pawn_squares:
		print("Creating black pawn at " + square + ": " + str(to_coords(square)))
		var white_pawn = black_pawn_scene.instantiate()
		white_pawn.position = to_coords(square)
		add_child(white_pawn)
		
	for square in white_rook_squares:
		print("Creating white rook at " + square + ": " + str(to_coords(square)))
		var white_rook = white_rook_scene.instantiate()
		white_rook.position = to_coords(square)
		add_child(white_rook)
		
	for square in black_rook_squares:
		print("Creating black rook at " + square + ": " + str(to_coords(square)))
		var white_rook = black_rook_scene.instantiate()
		white_rook.position = to_coords(square)
		add_child(white_rook)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func to_coords(alg: String):
	""" Converts algebraic notation to coordinates e.g. "b5" -> (4, 1) """
	assert(
		len(alg) == 2 and alg[0] in "abcdefgh" and alg[1] in "12345678", 
		"Invalid algebraic notation!")
	var file: String = alg[0]
	var rank: String = alg[1]

	const file_dict = {"a": 0, "b": 1, "c": 2, "d": 3, "e": 4, "f": 5, "g": 6, "h": 7}
	const rank_dict = {"1": 7, "2": 6, "3": 5, "4": 4, "5": 3, "6": 2, "7": 1, "8": 0}
	
	var file_coord: int = file_dict[file] * TILE_SIZE + TILE_SIZE/2
	var rank_coord: int = rank_dict[rank] * TILE_SIZE + TILE_SIZE/2
	
	return Vector2(file_coord, rank_coord)



func _get_position(alg: String):
	var square_coords: Array = to_coords(alg)
	return square_coords
