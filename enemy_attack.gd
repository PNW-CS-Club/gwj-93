extends Node2D
class_name EnemyAttack

var grid: Grid
enum Attacks {SQUARE, ROW_COLUMN, RANDOM}

var rng = RandomNumberGenerator.new()


var my_random_number = rng.randf_range(-10.0, 10.0)


var guaranteed_hit_chance: float = 0.10: set = on_guaranteed_hit_chance_set
var damage: int

func on_guaranteed_hit_chance_set(amount: float) -> void:
	guaranteed_hit_chance = clamp(amount, 0.0, 1.0)
	


func attack(type: Attacks) -> void:
	match type:
		Attacks.SQUARE:
			pass
		Attacks.ROW_COLUMN:
			pass
		Attacks.RANDOM:
			pass
	pass
