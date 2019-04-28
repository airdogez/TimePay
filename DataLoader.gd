extends Node
class_name DataLoader

export (String, FILE, "*.json") var data_file_path : String
var data

func _ready():
	load_data()

func load_data():
	var file = File.new()
	assert file.file_exists(data_file_path)
	file.open(data_file_path, file.READ)
	var text = parse_json(file.get_as_text())
	assert text.size() > 0
	data = text
	
func get_random_value():
	var size = data.size()
	return data[randi()%size]