extends Node
class_name Map_Decider
var file_path = "res://Data/easy_map.txt"

class Grid:
	var cells: Array
	
	func _init(chunk : Array):
		cells = []
		for line in chunk:
			cells.append(line.split(""))
			
	func get_cell(row:int, col:int) -> String:
		return cells[row][col]

	func set_cell(row:int, col: int, value: String):
		cells[row][col] = value
	
	func print_grid():
		for row in cells:
			print("".join(row))
			
	func for_each_cell(callback : Callable):
		for row in range(cells.size()):
			for col in range(cells[row].size()):
				callback.call(row,col-1, cells[row][col])
				
	func for_each_inner_cell(callback:Callable):
		for row in range(cells.size()):
			for col in range(1,cells[row].size()-1):
				callback.call(row,col -1, cells[row][col])

func read_and_split_file(in_file_path: String) -> Dictionary:
	var file = FileAccess.open(in_file_path, FileAccess.READ)
	var result := {}
	var current_key := ""
	var current_array := []
	var key_index = 0
	if file:
		while not file.eof_reached(): #reads until the end of the file based off the cursor
			var line = file.get_line().strip_edges() #gets everything line by line
			
			if "=" in line: #this resets each array
				if not current_key.is_empty():
					result[current_key] = current_array
				
				current_key = str(key_index)
				key_index += 1
				result[current_key] = current_array
					
				var parts = line.split("=", true, 1)
				current_key = parts[0]
				current_array = []
				
				if parts.size() > 1 and !parts[1].is_empty():
					current_array.append(parts[1])
			else:
				current_array.append(line)
				
		if not current_key.is_empty():
			result[current_key] = current_array
		
		file.close()
	return result
	
func get_random_chunk(in_data: Dictionary):
	if in_data.is_empty():
		return null
	var keys = in_data.keys()
	var random_number_range = randi_range(5,keys.size()-1)
	var random_key = keys[random_number_range]
	return in_data[random_key]
	
func get_specific_chunk(in_data : Dictionary, key : String):
	if in_data.is_empty():
		return null
	return in_data[key]
	
func parse_chunk_to_grid(chunk:Array) -> Array:
	var grid = []
	for line in chunk:
		grid.append(line.split(""))  #.substr(1, line.length() - 2).
	return grid


signal spawning(value_of_cell, pos)
var data : Dictionary
func _ready():
	data = read_and_split_file(file_path)

var off_set_y : int = 0

func make_specific_chunk(in_number: int ):
	var first = get_specific_chunk(data, str(in_number))	
	var grid = Grid.new(first)
	#grid.print_grid()
	grid.for_each_cell(func(row,col,value):
		var cell_pos : Vector2i= Vector2i(col*16, row*16 + off_set_y)
		spawning.emit(value, cell_pos))




func make_starting_chunk():
	var first = get_specific_chunk(data, "1")	
	var grid = Grid.new(first)
	#grid.print_grid()
	grid.for_each_cell(func(row,col,value):
		var cell_pos : Vector2i= Vector2i(col*16, row*16 + off_set_y)
		spawning.emit(value, cell_pos))

func make_ending_chunk():
	var first = get_specific_chunk(data, "2")	
	var grid = Grid.new(first)
	#grid.print_grid()
	grid.for_each_cell(func(row,col,value):
		var cell_pos : Vector2i= Vector2i(col*16, row*16 + off_set_y)
		spawning.emit(value, cell_pos))

func make_blank_chunk():
	var first = get_specific_chunk(data, "0")	
	var grid = Grid.new(first)
	#grid.print_grid()
	grid.for_each_cell(func(row,col,value):
		var cell_pos : Vector2i= Vector2i(col*16, row*16 + off_set_y)
		spawning.emit(value, cell_pos))

func make_one_chunk():
	var random_chunk = get_random_chunk(data)
	var grid = Grid.new(random_chunk)
	#grid.print_grid()
	grid.for_each_cell(func(row,col,value):
		var cell_pos : Vector2i= Vector2i(col*16, row*16 + off_set_y)
		spawning.emit(value, cell_pos))
