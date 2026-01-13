extends Node

@export var TotalFishArray : Array = []

const filepath : String = "res://Fish-type-mailslot.txt"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var f = FileAccess.open(filepath, FileAccess.READ)
	while not f.eof_reached():
		var line : String = f.get_line()
		TotalFishArray.append(line)
	f.close()
	print(filepath)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
