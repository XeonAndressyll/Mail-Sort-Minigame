extends Node2D

@onready var button : Button = $Button
@onready var button2 : Button = $Button2

@onready var target : Label = $TargetIcon

var FishData_scene: PackedScene = load("res://fish_data.tscn")
var FishData: Node = FishData_scene.instantiate()

var _FishButtonScene : PackedScene = load("res://FishButton.tscn")
var _FishButton : TextureButton = _FishButtonScene.instantiate()


var target_pool : Array= []
var file_location : String = "res://Fish-type-mailslot.txt"


func _ready() -> void:
	button.pressed.connect(button_press.bind(button))
	button2.pressed.connect(button_press.bind(button2))
	
	add_child(FishData)
	FishData.owner = self
	
	add_child(_FishButton)
	_FishButton.owner = self
	_FishButton.position = Vector2(200, 200)
	_FishButton.scale = Vector2(8, 8)
	
	$AcceptDialog.confirmed.connect(reset)

	fish_get_data()

	target_pool = $FishData.get_meta("TotalFishArray")
	
	print("What node.2d thinks TotalFishArray is: ", $FishData.get_meta("TotalFishArray"))
	
	reset()

func fish_get_data() -> void:
	var f = FileAccess.open(file_location, FileAccess.READ)
	var _array : Array = []
	while not f.eof_reached():
		var line : String = f.get_line()
		if line == "":
			pass
		else:
			_array.append(line)
	$FishData.set_meta("TotalFishArray", _array)
	f.close()
	print(_array)


func reset() -> void: 
	target.text = target_pool.pick_random()
	
	var target_wrongpool : Array= []
	
	for item in target_pool:
		if target.text == item:
			pass
		else:
			target_wrongpool.append(item)
	
	var button_pool : Array= [button, button2]
	
	#Defines correct_button as an index number within button_pool randomly
	var correct_button : int = randi()% button_pool.size()
	
	#Looks at available buttons and chooses what is correct (true)
	#Excludes anything not correct as false
	for i in range(button_pool.size()):
		if correct_button == i:
			button_pool[i].set_meta("correct_button", true)
			button_pool[i].text = target.text
			
		else:
			button_pool[i].set_meta("correct_button", false)
			print(button_pool[i])
			print(button_pool[i].get_meta("correct_button"))
			button_pool[i].text = target_wrongpool.pick_random()
		print(button_pool[i])
	
func button_press(pressed_button : Button) -> void :
	if pressed_button.get_meta("correct_button"):
		$AcceptDialog.dialog_text = "Gud"
		print(pressed_button.get_meta("correct_button"))
	else:
		$AcceptDialog.dialog_text = "Uh oh"
		print(pressed_button.get_meta("correct button"))

	$AcceptDialog.popup_centered()
	

	print("It got pressed")
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
