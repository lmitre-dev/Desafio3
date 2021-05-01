extends Node

onready var player = $Player
onready var background := $Background
onready var turret := $Turret
onready var star_scene := preload("res://entities/collectibles/Star.tscn")

var star_position := Vector2(1600,160)

func _ready():
	randomize()
	player.initialize(self)
	turret.initialize(self, turret.position, player, self)
	
	var star = star_scene.instance()
	add_child(star)
	star.set_position(star_position)
	
