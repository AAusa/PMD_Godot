extends Area2D
export (int) var Velocidad
var Movimiento = Vector2()
var limite
signal golpe

func _ready():
	hide()#Ocultar el personaje
	limite = get_viewport_rect().size
	


func _process(delta):
	Movimiento = Vector2() # Reiniciar el movimiento despues de pulsar
	# Movimientos al pulsar teclas:
	if Input.is_action_pressed("ui_right"):
		Movimiento.x += 1
	if Input.is_action_pressed("ui_left"):
		Movimiento.x -= 1
	if Input.is_action_pressed("ui_down"):
		Movimiento.y += 1
	if Input.is_action_pressed("ui_up"):
		Movimiento.y -= 1
		
	if Movimiento.length() > 0: # Verifica si se está moviendo
		Movimiento = Movimiento.normalized() * Velocidad # Normalilza la velocidad

	position += Movimiento * delta # delta permite que el timing en el juego sea el mismo en cualquier ordenador
	position.x = clamp(position.x, 0, 490) #Limites de pantalla
	position.y = clamp(position.y, 310, 1010)
	
	if Movimiento.x != 0: # Si se mueve en el eje x sprite lado
		$Sprite_player.animation = "lado"
		$Sprite_player.flip_h = Movimiento.x > 0 # Si se mueve a la izq. se voltea el sprite horizontalmente
		$Sprite_player.flip_v = false
	elif Movimiento.y != 0: # Si se mueve en el eje y sprite espalda
		$Sprite_player.animation = "espalda"
		$Sprite_player.flip_v = Movimiento.y > 0# Si se mueve hacia arriba se voltea el sprite verticalmente
	else: # Si se mueve en el eje x sprite lado
		$Sprite_player.animation = "frente"



	
func inicio(pos):
	position = pos
	show()#Mostrar el personaje
	$CollisionShape2D.disabled = false;


func _on_Player_body_entered(_body):
	hide()
	emit_signal("golpe")
	$CollisionShape2D.disabled = true
