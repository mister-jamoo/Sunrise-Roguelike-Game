extends KinematicBody2D

var bloodsplatter = preload("res://Scenes/BloodSplatter.tscn")
var velocity = Vector2()
var attackBool = false
var canMove = true
var rng : RandomNumberGenerator = RandomNumberGenerator.new()
export var rotation_speed = PI
signal take_damage

func _ready():
	$PlayerStats.connect("death", self, "deathfunc")

func get_input():
	if(canMove):
		velocity = Vector2()
		if Input.is_action_pressed("right"):
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.position.x = -3
			$Hitbox.scale.x = 1
			velocity.x += 1
		if Input.is_action_pressed("left"):
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.position.x = 3
			$Hitbox.scale.x = -1
			velocity.x -= 1
		if Input.is_action_pressed("down"):
			velocity.y += 1
		if Input.is_action_pressed("up"):
			velocity.y -= 1
		if Input.is_action_pressed("attack"):
			attackBool = true
		if(velocity == Vector2.ZERO && !attackBool):
			$AnimationPlayer.play("Idle")
			
		if(velocity != Vector2.ZERO):
			attackReset()
			
		if(velocity != Vector2.ZERO):	
			$AnimationPlayer.play("Run")
		
		$AnimationPlayer.playback_speed = $PlayerStats.movement_speed / 40
		if(attackBool):
			$AnimationPlayer.playback_speed = $PlayerStats.attack_speed
			$AnimationPlayer.play("Attack")
			
		velocity = velocity.normalized() * $PlayerStats.movement_speed
		velocity = move_and_slide(velocity)

func moveFalse():
	canMove = false
	
func moveTrue():
	canMove = true
	
func attackReset():
	attackBool = false;

func deathfunc():
	$AnimationPlayer.play("Death")
	get_tree().paused = true

func getXP(xp_amount):
	$PlayerStats.current_xp += xp_amount
	if($PlayerStats.current_xp >= $PlayerStats.max_xp):
		$PlayerStats.update_level_xp()
	else:
		$PlayerStats.update_xp()

func _physics_process(delta):
	get_input()
	
func dealDamage():
		var targets = $Hitbox.get_overlapping_bodies()
		for n in targets:
			var crit_chance = rand_range(0,1)
			var hit_chance = rand_range(0,1)
			var crit = false;
			var damage : int = 0
			
			if($PlayerStats.hit_rating <= hit_chance):
				damage = 0
				crit = false
				n.takeDamage(damage, crit)
				
			elif ($PlayerStats.crit_chance >= crit_chance):
				damage = rng.randi_range($PlayerStats.base_damage * 3, $PlayerStats.base_damage * 4)
				crit = true
				n.takeDamage(damage, crit)
				
			else:
				damage = rng.randi_range($PlayerStats.base_damage, $PlayerStats.base_damage * 2)
				crit = false
				n.takeDamage(damage, crit)
			
func takeDamage(damage):
#	damage reduction
	damage -= int(damage * $PlayerStats.armor)

	$PlayerStats.current_health -= damage
	emit_signal("take_damage")
	
	var instance = bloodsplatter.instance()
	add_child(instance)
	instance.emitting = true
	
	if($PlayerStats.current_health <= 0):
		deathfunc()





