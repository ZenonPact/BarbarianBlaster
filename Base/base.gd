extends Node3D


@export var max_health: int = 5

@onready var green_health_bar: MeshInstance3D = $GreenHealthBar
@onready var label_3d: Label3D = $Label3D
@onready var percent_label: Label3D = $RedHealthBar/PercentLabel

@export var original_health_bar_width: float


var current_health: int:
	set(health_in):
		current_health = health_in
		#label_3d.text = str(current_health) + "/" + str(max_health)
		#var red: Color = Color.RED
		#var white: Color = Color.WHITE
		#label_3d.modulate = red.lerp(white, float(current_health) / float(max_health))
		#percent_label.text = str((float(current_health) / float(max_health)) * 100) + "%"
		if current_health < 1:
			get_tree().reload_current_scene()


func _ready() -> void:
	current_health = max_health
	green_health_bar.mesh.size.x = original_health_bar_width
	Engine.time_scale = 10


func take_damage() -> void:
	current_health -= 1
	set_health_bar()

func set_health_bar() -> void:
	var health_percentage = (float(current_health) / float(max_health))
	green_health_bar.mesh.size.x = original_health_bar_width * health_percentage
	green_health_bar.position.x = - original_health_bar_width * (1 - health_percentage) / 2
