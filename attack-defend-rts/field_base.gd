extends RigidBody3D

@onready var camera_path = get_tree().get_root().get_node("Map").get_node("Camera").get_node("Player Camera")
var units = {
	"Rifleman" = preload('res://Units/Rifleman/rifleman.tscn')
}

func _process(delta: float) -> void:
	if is_in_group("Placing"):
		var raycast_result = camera_path.shoot_ray()
		position = raycast_result["position"]

func select():
	$CanvasLayer.show()
	$"Selection Indicator".show()
	add_to_group("Selected")

func deselect():
	$CanvasLayer.hide()
	$"Selection Indicator".hide()
	remove_from_group("Selected")

func spawn_unit(unit,team):
	unit = units[unit]
	var unit_instantiated = unit.instantiate()
	unit_instantiated.position = $"Spawn Point".global_position
	var color = null
	if team == "red":
		color = get_tree().get_root().get_node("Map").blue_material
	elif team == "blue":
		color = get_tree().get_root().get_node("Map").red_material
	unit_instantiated.set_values(team,color)
	get_tree().get_root().get_node("Map").add_child(unit_instantiated)
