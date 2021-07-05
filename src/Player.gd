extends KinematicBody2D

var velocity: Vector2 = Vector2(0, 0)
export var speed: float = 2.0

func _ready():
	$Anim.play("idle")

func _physics_process(_delta):
	if Input.is_action_pressed("ui_right"):
		$Anim.play("walk")
		$Anim.scale.x = 1
		velocity.x = speed
	elif Input.is_action_pressed("ui_left"):
		$Anim.play("walk")
		$Anim.scale.x = -1
		velocity.x = -speed
	else:
		$Anim.play("idle")
		velocity.x = 0

	if velocity.x:
		move_and_collide(velocity)
