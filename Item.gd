extends Resource

class_name Item

#This allow for the creation of item in form of Resource and allows you apply the itemName and texture 
#We could also use hard code but we might have to use a .tres in order to store specific data for the plants
@export var itemName: String
@export var texture: CompressedTexture2D
@export var plantResource: PlantResource #this is used for a .tres file in which stores stats for each plant
