extends Area3D

@export var speed: int = 100
var direction: Vector3 = Vector3.FORWARD

func _ready() -> void:
	$Projectile.rotation_degrees = Vector3(420,0,840)

func _process(delta: float) -> void:
	position += direction * speed * delta
	#$Projectile.rotation_degrees += direction * (speed + 50) * delta
	$Projectile.rotation_degrees += Vector3(60,0,120) * 2 * delta


func _on_body_entered(body: Node3D) -> void:
	if "hit" in body:
		body.hit()
