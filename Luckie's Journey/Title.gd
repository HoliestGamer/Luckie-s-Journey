extends Control


func _ready():
	$Menu/Container/Buttons/NewGameButton.grab_focus()
	for button in $Menu/Container/Buttons/NewGameButton.get_children():
		button.connect("pressed", self, "_on_NewGameButton_pressed")
