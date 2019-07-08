extends Area2D

signal earth_is_hit

var health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_EarthArea_body_entered(body):
	health = health - 1
	emit_signal("earth_is_hit")
