extends Node2D

@export_dir var biomeDirectory : String
@export var biomesNumber : int = 3
@export var lastBiome : BiomeResource

var previousBiome : Biome
var biomes : Array[BiomeResource]

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	
	dir_contents(biomeDirectory + "/")
	for i in biomesNumber:
		var index : int = rng.randi_range(0, biomes.size() - 1)
		
		var biomeResource : BiomeResource = biomes[index]
		
		if i == 0:
			previousBiome = spawnBiome(biomeResource)
		else:
			previousBiome = spawnBiome(biomeResource, previousBiome)
	
	spawnBiome(lastBiome, previousBiome)
	#previousBiome = spawnBiome(biomeResource)
	#spawnBiome(biomeResource, previousBiome)

func spawnBiome(biomeResource : BiomeResource, prevBiome : Biome = null) -> Biome: #HACK: We probably shouldn't spawn in the entire level at once for performance reason
	var biome : Biome = biomeResource.biomeScene.instantiate()
	add_child(biome)
	
	if prevBiome:
		biome.config(prevBiome.endingMarker)
	
	return biome

func dir_contents(path): ##Gets all the level resources in the levels folder
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				var biome = load(path + file_name)
				biomes.append(biome)
				
			file_name = dir.get_next()
	else:
		printerr("An error occurred when trying to access the path.")
