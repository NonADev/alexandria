extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite
const UP = Vector2(0, -1)
const MAX_SPEED = 80
const ACCELERATION = 500
const FRICTION = 600
var motion = Vector2.ZERO
var dialogBody = null
var state = MOVE
enum {
	MOVE,
	DIALOG
}


func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
			interactions()
			if is_on_wall():
				animatedSprite.play("Idle")
		DIALOG:
			dialog_state(delta)
			
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	motion.y += 14;
	motion = move_and_slide(motion, UP)


func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input_vector != Vector2.ZERO:
		animatedSprite.flip_h = input_vector.x > 0
		animatedSprite.play("Run")
		motion = motion.move_toward(input_vector * MAX_SPEED, delta * ACCELERATION)
	else:
		animatedSprite.play("Idle")
		motion = motion.move_toward(Vector2.ZERO, delta * FRICTION)
	
	if motion.x>0:
		animatedSprite.flip_h = false
	elif motion.x < 0:
		animatedSprite.flip_h = true


func interactions():
	if dialogBody != null && dialogBody.has_method("readBook") && Input.is_action_just_pressed("ui_accept"):
		var dialogBox = dialogBody.readBook()
		animatedSprite.play("Idle")
		state = DIALOG
		dialogBox.connect("dialog_ended", self, "_on_dialogBox_ended")


func dialog_state(delta):
	animatedSprite.play("Idle")
	motion = motion.move_toward(Vector2.ZERO, delta * FRICTION)


func _on_dialogBox_ended():
	state = MOVE


func _on_InteractionArea_area_entered(area):
	if area.has_method("readBook"):
		dialogBody = area


func _on_InteractionArea_area_exited(_area):
	dialogBody = null
