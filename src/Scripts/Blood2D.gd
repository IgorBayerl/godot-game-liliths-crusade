extends Node2D

export var BloodParticleScene : PackedScene
export var BloodParticleNumber := 15
export var RandomVelocity := 500.0

const BloodSplatterSignalName := "OnDeath"

var rnd = RandomNumberGenerator.new()


func _ready() -> void:
	for parentSignal in get_parent().get_signal_list():
		if(parentSignal["name"] == BloodSplatterSignalName):
			get_parent().connect(BloodSplatterSignalName,self, "on_parent_death")
	rnd.randomize()
	
func on_parent_death(parent : Node):
	splatter()
	
func splatter(particles_to_spawn := -1):
	if (particles_to_spawn <= 0):
		particles_to_spawn = BloodParticleNumber
		
	var spawnedParticles : RigidBody2D
	
	for i in range(particles_to_spawn):
		spawnedParticles = BloodParticleScene.instance()
		
		get_tree().root.add_child((spawnedParticles))
		
		spawnedParticles.global_position = global_position
		
		spawnedParticles.linear_velocity = Vector2(rnd.randf_range(-RandomVelocity, RandomVelocity), rnd.randf_range(-RandomVelocity, RandomVelocity))
		



