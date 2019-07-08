extends Node2D


export (PackedScene) var Enemy


func _ready():
	randomize() # so that the randomized enemy types are not the same on each game play




func _on_EnemyFrequencyTimer_timeout():
	# Choose a random location on Path2D.
	$EnemyPath/EnemyPathFollow.set_offset(randi())
	# Create a Enemy instance and add it to the scene.
	var enemy_orb = Enemy.instance()
	add_child(enemy_orb)
	# Set the enemy_orb's direction perpendicular to the path direction.
	var direction = $EnemyPath/EnemyPathFollow.rotation + PI / 2
	# Set the enemy_orb's position to a random location.
	enemy_orb.position = $EnemyPath/EnemyPathFollow.position
	enemy_orb.earth_shield_position = $EarthProtector.position



