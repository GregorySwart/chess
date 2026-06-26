class_name Utils

const TILE_SIZE = 64  # TODO move this to a config file

static func pixel_coords_to_alg(coordinates: Vector2) -> String:
	# Converts coordinates to algebraic notation e.g. (97, 223) -> "b5" 
		
	# 	Depending on TILE_SIZE, multiple coordinates will correspond to the same square e.g.
	# 	(0, 0) to (63, 63) -> "a8"
	# 	(64, 0) to (127, 63) -> "b8"
	# 	(127, 63) to (64, 0) -> "a7"
	# 	(127, 63) to (127, 63) -> "b7" etc. (for TILE_SIZE=64)

	assert(
		0 <= coordinates.x and coordinates.x <= 511 and 0 <= coordinates.y and coordinates.y <= 511,
		"Invalid coordinates! - Both coordinates must be within the range [0-511]"
	)
	
	const FILE_DICT = {0: "a", 1: "b", 2: "c", 3: "d", 4: "e", 5: "f", 6: "g", 7: "h"}
	const RANK_DICT = {7: "1", 6: "2", 5: "3", 4: "4", 3: "5", 2: "6", 1: "7", 0: "8"}
	
	var file: String = FILE_DICT[int(floor(coordinates.x)) / TILE_SIZE]
	var rank: String = RANK_DICT[int(floor(coordinates.y)) / TILE_SIZE]
	
	return file + rank


static func alg_to_pixel_coords(alg: String) -> Vector2:
	# Converts algebraic notation to coordinates e.g. "b5" -> (96.0, 224.0)
		
	# 	Unlike `pixel_coords_to_alg`, this function will NOT return a region of pixels but point to the centre of each
	#   square e.g.
	# 	"a8" -> (32, 32)
	# 	"a7" -> (32, 96)
	# 	"b8" -> (96, 32)
	# 	"b7" -> (96, 96) etc.

	assert(
		len(alg) == 2 and alg[0] in "abcdefgh" and alg[1] in "12345678",
		"Invalid algebraic notation! - Notation must be a String of length 2 comprised of a letter [a-h] and a number \
		[1-8] e.g. 'd6'"
	)
	var file: String = alg[0]
	var rank: String = alg[1]

	const FILE_DICT = {"a": 0, "b": 1, "c": 2, "d": 3, "e": 4, "f": 5, "g": 6, "h": 7}
	const RANK_DICT = {"1": 7, "2": 6, "3": 5, "4": 4, "5": 3, "6": 2, "7": 1, "8": 0}
	
	var file_coord: int = FILE_DICT[file] * TILE_SIZE + TILE_SIZE/2
	var rank_coord: int = RANK_DICT[rank] * TILE_SIZE + TILE_SIZE/2
	
	return Vector2(file_coord, rank_coord)


static func alg_to_board_coords(alg: String) -> Vector2i:
	# Convert algebraic notation to 'board coordinates' e.g. "a1" -> (1, 1), "b3" -> (2, 3) etc.
	const FILE_DICT = {"a": 1, "b": 2, "c": 3, "d": 4, "e": 5, "f": 6, "g": 7, "h": 8}
	const RANK_DICT = {"1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8}
	assert(
		len(alg) == 2 and alg[0] in "abcdefgh" and alg[1] in "12345678",
		"Invalid algebraic notation! - Notation must be a String of length 2 comprised of a letter [a-h] and a number \
		[1-8] e.g. 'd6'"
	)
	var file: int = int(FILE_DICT[alg[0]])
	var rank: int = int(RANK_DICT[alg[1]])
	return Vector2(file, rank)


static func board_coords_to_alg(board_coords: Vector2i) -> String:
	# Convert 'board coordinates' to algebraic notation e.g. (1, 1) -> "a1", (2, 3) -> "b3" etc.
	const FILE_DICT = {1: "a", 2: "b", 3: "c", 4: "d", 5: "e", 6: "f", 7: "g", 8: "h"}
	const RANK_DICT = {1: "1", 2: "2", 3: "3", 4: "4", 5: "5", 6: "6", 7: "7", 8: "8"}
	var file: String = FILE_DICT[int(board_coords.x)]
	var rank: String = RANK_DICT[int(board_coords.y)]
	return file + rank
	
static func update_turn(turn: String) -> String:
	var new_turn: String = {"black": "white", "white": "black"}[turn]
	print("Chaging turn %s -> %s" % [turn, new_turn])
	return new_turn
