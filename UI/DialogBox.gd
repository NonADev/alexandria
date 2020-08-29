extends Control

export(Array, String) var dialog = [
	'Hello thu hathere, this is a text for you readhu hathere, this is a text for you readhu hathere, this is a text for you readhu hathere, this is a text for you readhu hathere, this is a text for you readhu hathere, this is a text for you readhu hathere, this is a text for you readhu hathere, this is a text for you read.',
	'If you have died, please, right door, otherwise, go ahead.',
	'You dont know? ok, go back.'
]
onready var richTextLabel = $Frente/RichTextLabel
onready var nextIndicator = $Frente/NextIndicator
onready var tween = $Tween
var dialog_index = 0
signal dialog_ended

func _ready():
	load_dialog()


func _process(delta):
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


func _on_Tween_tween_completed(object, key):
	nextIndicator.visible = true


func _on_Tween_tween_started(object, key):
	nextIndicator.visible = false
