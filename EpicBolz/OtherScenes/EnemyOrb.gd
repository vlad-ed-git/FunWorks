extends KinematicBody2D


export var min_speed = 250  # Minimum speed range.
export var max_speed = 500  # Maximum speed range
var moving = true
var earth_shield_position = Vector2(0,0)
var green_orb = preload("res://assets/sprites/orbs/green_orb.png")
var blue_orb  = preload("res://assets/sprites/orbs/blue_orb.png")
var purple_orb = preload("res://assets/sprites/orbs/purple_orb.png")
var red_orb = preload("res://assets/sprites/orbs/red_orb.png")
var gold_orb = preload("res://assets/sprites/orbs/gold_orb.png")
var enemy_orb_types = [green_orb, blue_orb, purple_orb, red_orb, gold_orb]
var enemy_orb_type = null


# Called when the node enters the scene tree for the first time.
func _enter_tree():
	if enemy_orb_type == null:
		# randomly generate a type
		enemy_orb_type = enemy_orb_types[randi() % enemy_orb_types.size()] 
	$Sprite.texture = enemy_orb_type



# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if moving:
		var direction = (earth_shield_position - position ).normalized()
		var motion = direction * rand_range(min_speed, max_speed) * delta
		var collision = move_and_collide(motion)
		if collision:
			moving = false
			if collision.collider.has_method('_capture_enemy'):
				# then enemy has been captured by earth shield
				collision.collider._capture_enemy(self, global_position)
			elif collision.collider.has_method('_enemy_collide_with_self'):
				# then an enemy has collided with another enemy
				collision.collider._enemy_collide_with_self(self, global_position) 
		

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()  # delete if leaves the screen 

func _enemy_collide_with_self(enemy, enemy_og_pos):
	if enemy_orb_type == enemy.enemy_orb_type: 
		# two similar enemies have collided
		enemy.queue_free()
		queue_free()
	else:
		enemy.get_parent().remove_child(enemy) # error here  
		add_child(enemy)
		enemy.global_position = enemy_og_pos
		enemy.moving = false