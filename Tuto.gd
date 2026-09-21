extends Node2D

func _on_ZonaSiguienteNivel_area_entered(area):
	if area.name == "Area2D":
		get_tree().change_scene("res://Nivel2.tscn")
