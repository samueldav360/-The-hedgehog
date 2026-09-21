extends KinematicBody2D

export var VELOCIDAD = 300.0
export var FUERZA_SALTO = -800.0
export var GRAVEDAD = 1200.0

const UP = Vector2.UP

var movimiento = Vector2.ZERO

onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	movimiento.y += GRAVEDAD * delta

	var direccion = 0
	if Input.is_action_pressed("ui_right"):
		direccion += 1
	if Input.is_action_pressed("ui_left"):
		direccion -= 1
		
	if direccion != 0:
		movimiento.x = direccion * VELOCIDAD
	else:
		movimiento.x = 0
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			movimiento.y = FUERZA_SALTO

	movimiento = move_and_slide(movimiento, UP)

	actualizar_animaciones(direccion)

onready var sprite_animado = $AnimatedSprite
onready var sprite_estatico = $Sprite
onready var sprite_estatico2 = $saltar


func actualizar_animaciones(direccion):
	if direccion > 0:
		sprite_animado.flip_h = false
		sprite_estatico.flip_h = false
		sprite_estatico2.flip_h = false 
	elif direccion < 0:
		sprite_animado.flip_h = true
		sprite_estatico.flip_h = true
		sprite_estatico2.flip_h = true

	if not is_on_floor():
		sprite_animado.visible = false
		sprite_estatico.visible = false
		sprite_estatico2.visible = true
		
	elif direccion != 0:
		sprite_animado.visible = true
		sprite_estatico2.visible = false
		sprite_estatico.visible = false
		sprite_animado.play("caminar")
		
	else:
		sprite_animado.visible = false
		sprite_estatico2.visible = false
		sprite_estatico.visible = true
		sprite_animado.stop() 



func _on_Area2D_area_entered(area):
	if area.is_in_group("Peligro"):
		morir()

func morir():
	print("El personaje ha muerto")
	get_tree().reload_current_scene()
