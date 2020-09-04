extends StaticBody2D


export(Array, String) var textFromBook = ["primeira frase", "segunda fase"]


func readBook():
	var instanceDialog = load("res://UI/DialogBox.tscn").instance()
	instanceDialog.dialog = textFromBook
	get_node("../../HUD").add_child(instanceDialog)
	instanceDialog.start_dialog()
	return instanceDialog
