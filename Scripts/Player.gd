extends KinematicBody2D

const Inventory = preload("res://Scenes/Inventory.gd")
const Equipment = preload("res://Equipment.gd")
const Traits = preload("res://Traits.gd")

signal take_damage

var axe_of_savagery = preload("res://Axe_of_Savagery.tscn")
var shield_of_slowing = preload("res://Shield_of_Slowing.tscn")
var shield_count : int
var staff_of_solar = preload("res://Staff of Solar.tscn")

var inventory = Inventory.new()
var equipment = Equipment.new()
var traits = Traits.new()
var bloodsplatter = preload("res://Scenes/BloodSplatter.tscn")
var velocity = Vector2()
var attackBool = false
var canMove = true
var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	$PlayerStats.connect("death", self, "deathfunc")
	shield_count = 0

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
	
func instance_weapon(weapon):
	if(weapon.title == "Axe of Savagery"):
		var axes_pivot = $Buffs/Axes/pivot
		var axe_instance = axe_of_savagery.instance()
		axes_pivot.add_child(axe_instance)
		update_axes(axes_pivot.get_child_count())
		axe_instance.connect("deal_damage", self, "deal_axe_damage")
		
	if(weapon.title == "Shield of Slowing"):
		var shields = $Buffs/Shields
		if(shield_count < 1):
			var shield_instance = shield_of_slowing.instance()	
			shields.add_child(shield_instance)
			shield_count += 1
		else:
			shield_count += 1
		
		update_shields(shield_count)

	if(weapon.title == "Staff of Solar"):
		var staves = $Buffs/Staves
		var staff = staff_of_solar.instance()
		staff.position = Vector2(-14,-12)
		staves.add_child(staff)
		update_staves(staves.get_child_count())
				

func remove_weapon(weapon):
	if(weapon.title == "Axe of Savagery"):
		var axes = $Buffs/Axes/pivot
		update_axes(axes.get_child_count() - 1)
		axes.get_children().back().queue_free()
		
	if(weapon.title == "Shield of Slowing"):
		var shields = $Buffs/Shields
		shield_count -= 1
		update_shields(shield_count)
		if(shield_count == 0):
			shields.get_child(0).queue_free()
#		
	if(weapon.title == "Staff of Solar"):
		var staves = $Buffs/Staves
		update_staves(staves.get_child_count() - 1)
		staves.get_children().back().queue_free()
		

func update_shields(count):
	var shield = $Buffs/Shields
	match(count):
		1:
			shield.get_child(0).slow_amount = 0.75
		2:
			shield.get_child(0).slow_amount = 0.65
		3:
			shield.get_child(0).slow_amount = 0.55
		4:
			shield.get_child(0).slow_amount = 0.45	

func update_axes(count):
	var pivot = $Buffs/Axes/pivot
	pivot.rotation = 0
	match(count):
		1:
			pivot.get_child(0).position.x = 40
			pivot.get_child(0).position.y = 0
		2:
			pivot.get_child(0).position.x = 40
			pivot.get_child(0).position.y = 0
			
			pivot.get_child(1).position.x = -40
			pivot.get_child(1).position.y = 0
		3:
			pivot.get_child(0).position.x = 40
			pivot.get_child(0).position.y = 0
			
			pivot.get_child(1).position.x = -40
			pivot.get_child(1).position.y = 0
			
			pivot.get_child(2).position.x = 0
			pivot.get_child(2).position.y = 40
		4:
			pivot.get_child(0).position.x = 40
			pivot.get_child(0).position.y = 0
			
			pivot.get_child(1).position.x = -40
			pivot.get_child(1).position.y = 0
			
			pivot.get_child(2).position.x = 0
			pivot.get_child(2).position.y = 40
			
			pivot.get_child(3).position.x = 0
			pivot.get_child(3).position.y = -40
		

func update_staves(count):
	var staves = $Buffs/Staves
	match(count):
		1:
			staves.get_child(0).rotation_degrees = 0
		2:
			staves.get_child(0).rotation_degrees = 0
			staves.get_child(1).rotation_degrees = 90
		3:
			staves.get_child(0).rotation_degrees = 0
			staves.get_child(1).rotation_degrees = 120
			staves.get_child(2).rotation_degrees = 240
		4:
			staves.get_child(0).rotation_degrees = 0
			staves.get_child(1).rotation_degrees = 90
			staves.get_child(2).rotation_degrees = 180
			staves.get_child(3).rotation_degrees = 270
			
	for staff in staves.get_children():
		staff.get_node("AnimatedSprite").frame = 0
	
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
	
	
func deal_solar_damage():
	var crit_chance = rand_range(0,1)
	var hit_chance = rand_range(0,1)
	var crit = false;
	var damage : int = 0
	var damageArr = []
	
	if($PlayerStats.hit_rating <= hit_chance):
		damage = 0
		crit = false
		damageArr.append(damage)
		damageArr.append(crit)
		return damageArr
		
	elif ($PlayerStats.crit_chance >= crit_chance):
		damage = rng.randi_range($PlayerStats.base_damage * 3, $PlayerStats.base_damage * 4)
		crit = true
		damageArr.append(damage)
		damageArr.append(crit)
		return damageArr
		
	else:
		damage = rng.randi_range($PlayerStats.base_damage, $PlayerStats.base_damage * 2)
		crit = false
		damageArr.append(damage)
		damageArr.append(crit)
		return damageArr
	
func deal_axe_damage(body):
	var target = body
	var crit_chance = rand_range(0,1)
	var hit_chance = rand_range(0,1)
	var crit = false;
	var damage : int = 0
	
	if($PlayerStats.hit_rating <= hit_chance):
		damage = 0
		crit = false
		target.takeDamage(damage, crit)
		
	elif ($PlayerStats.crit_chance >= crit_chance):
		damage = rng.randi_range($PlayerStats.base_damage * 3, $PlayerStats.base_damage * 4)
		crit = true
		target.takeDamage(damage, crit)
		
	else:
		damage = rng.randi_range($PlayerStats.base_damage, $PlayerStats.base_damage * 2)
		crit = false
		target.takeDamage(damage, crit)
	
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





