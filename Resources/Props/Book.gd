extends StaticBody2D


func readBook():
	var instanceDialog = load("res://UI/DialogBox.tscn").instance()
	instanceDialog.dialog = ["primeira frase", "segunda fase"]
	get_node("../../HUD").add_child(instanceDialog)
	instanceDialog.start_dialog()
	return instanceDialog
