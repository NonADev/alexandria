extends Camera2D

onready var positionTopLeft = $PositionTopLeft
onready var positionBottomRight = $PositionBottomRight


func _ready():
	limit_top = positionTopLeft.global_position.y
	limit_left = positionTopLeft.global_position.x
	limit_bottom = positionBottomRight.global_position.y
	limit_right = positionBottomRight.global_position.x
