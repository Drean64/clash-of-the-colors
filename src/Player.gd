extends KinematicBody2D

export var speed: float = 2.0
export(NodePath) onready var anim = get_node(anim) as AnimationPlayer
export(NodePath) onready var sprite = get_node(sprite) as Sprite
var velocity: Vector2 = Vector2(0, 0)

func _ready():
	anim.play("arthur-idle")

func _physics_process(_delta):
	if Input.is_action_pressed("ui_right"):
		anim.play("arthur-walk-right")
		velocity.x = speed
	elif Input.is_action_pressed("ui_left"):
		anim.play("arthur-walk-left")
		velocity.x = -speed
	else:
		anim.play("arthur-idle")
		velocity.x = 0

	if velocity.x:
		move_and_collide(velocity)
