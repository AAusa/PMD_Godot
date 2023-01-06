extends RigidBody2D

export (int) var velocidad_min
export (int) var velocidad_max
var tipo_roca = ["grande", "chiquito"]

func _ready():
	$AnimatedSprite.animation = tipo_roca[randi() % tipo_roca.size()] #Eleccion aleatoria de roca
	
	if $AnimatedSprite.animation == "grande":#resize de colision en el caso de que sea grande
		$CollisionShape2D.scale.x = 1.2
		$CollisionShape2D.scale.y = 1.2		


func _on_Visibilidad_screen_exited():
	queue_free()#eliminar la roca
