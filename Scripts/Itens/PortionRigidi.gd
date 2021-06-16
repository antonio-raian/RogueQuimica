extends RigidBody2D

func _ready():
	$Potions/CollisionShape2D.disabled = true
	yield(get_tree().create_timer(0.2), "timeout")	
	$Potions/CollisionShape2D.disabled = false
	pass
