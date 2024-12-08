extends "res://scripts/platform.gd"

var direction := Vector2.RIGHT
var velocity := Vector2.ZERO
export var speed := 100

onready var screen_size := get_viewport_rect().size
onready var anim := $anim as AnimatedSprite

func _physics_process(delta):
	movement(delta)

func movement(delta):
	velocity = direction * speed
	position += velocity * delta
	
	if position.x >= 99:
		direction *= -1
		anim.flip_h = !anim.flip_h
	elif position.x <= -58:
			direction *= -1
			anim.flip_h = !anim.flip_h
			
func response():
	emit_signal("delete_object",self)


func _on_hitbox_body_entered(body: Node):
	if body.is_in_group("Player") and body.has_method("die"):
		body.die()
