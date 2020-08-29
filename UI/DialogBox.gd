extends Control

export(Array, String) var dialog = []
onready var richTextLabel = $Frente/RichTextLabel
onready var nextIndicator = $Frente/NextIndicator
onready var tween = $Tween
var dialog_index = 0
signal dialog_started
signal dialog_ended


func start_dialog():
	emit_signal("dialog_started")
	visible = true
	if dialog.size() == 0:
		push_error("Dialog null")
		get_tree().quit()
	else:
		load_dialog()


func _process(_delta):
	if richTextLabel.percent_visible==1 && Input.is_action_just_pressed("ui_accept"):
		load_dialog()


func load_dialog():
	if dialog_index < dialog.size():
		var dialog_visible_velocity = dialog[dialog_index].length() * 0.04
		richTextLabel.bbcode_text = dialog[dialog_index]
		richTextLabel.percent_visible = 0
		tween.interpolate_property(richTextLabel,"percent_visible",0,1,dialog_visible_velocity,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	else:
		emit_signal("dialog_ended")
		queue_free()
	dialog_index += 1


func _on_Tween_tween_completed(_object, _key):
	nextIndicator.visible = true


func _on_Tween_tween_started(_object, _key):
	nextIndicator.visible = false
