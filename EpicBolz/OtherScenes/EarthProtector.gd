extends StaticBody2D


var earth_protector_damage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var mouse_position = get_local_mouse_position()
	rotation += mouse_position.angle() * 0.1 

	 

func _capture_enemy(enemy, enemy_og_pos):
	enemy.get_parent().remove_child(enemy) # error here  
	add_child(enemy)
	enemy.global_position = enemy_og_pos
	enemy.moving = false
    
	
	
func _damaged():
	earth_protector_damage = earth_protector_damage - 1