extends Node
export (PackedScene) var Roca
var Score

func _ready():
	randomize()

func nuevo_juego():
	Score = 0
	$Player.inicio($PosicionDeInicio.position) #Posicion de inicio del Player
	$InicioTimer.start()

func game_over():
	$ScoreTimer.stop()
	$RocaTimer.stop()


func _on_InicioTimer_timeout():
	$RocaTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	Score += 1


func _on_RocaTimer_timeout():
	#Creacion de una roca y dados atributos de la roca
	$camino/RocaPosicion.set_offset(randi())#Seleccionar un lugar aleatorio en el path o camino
	var R = Roca.instance()
	add_child(R)
	
	
	var d = $camino/RocaPosicion.rotation + PI /2#Seleccionar una direccion
	
	R.position = $camino/RocaPosicion.position
	
	d += rand_range(-PI / 4, PI / 4)#Se utiliza PI para la direccion de los grados
	R.rotation = d
	R.set_linear_velocity(Vector2(rand_range(R.velocidad_min, R.velocidad_max), 0).rotated(d))
	
