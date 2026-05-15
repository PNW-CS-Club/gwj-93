class_name Item extends Resource

enum Type {
	HP_SEED, BUFF_SEED, DEF_SEED,
	WATER, SHOVEL
}

@export var type: Type
@export var name: String
@export var texture: Texture2D
