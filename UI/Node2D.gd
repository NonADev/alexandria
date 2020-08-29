extends Node2D

var instaceDialogBox = load("res://UI/DialogBox.tscn")
var dialog = true

func _process(delta):
	if dialog && Input.is_action_just_pressed("ui_accept"):
		dialog = false
		var i = instaceDialogBox.instance()
		i.visible = true
		$CanvasLayer.add_child(i)
	
