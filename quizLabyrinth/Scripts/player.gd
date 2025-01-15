extends CharacterBody3D

# Variáveis para controle do movimento
var moving_forward = false
var moving_backward = false
var rotating_left = false
var rotating_right = false
var moving_multi = 0
var rotating_multi = 0
@export var speed: float
@export var rotation_speed: float = 1.0 
var target_rotation: float = 0.0
var initial_click_position: Vector2 = Vector2.ZERO

# Função para detectar o início do clique do mouse
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			initial_click_position = event.position
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed():
			moving_forward = false
			moving_backward = false
			rotating_right = false
			rotating_left = false
	elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			var mouse_delta = event.position - initial_click_position
			#if abs(mouse_delta.y) < 10:
		#		moving_multi = 0
			#elif abs(mouse_delta.y) > 10 && abs(mouse_delta.y) < 15:
			#	moving_multi = 1
			#else:
			#	moving_multi = 3
			#print (mouse_delta)
			if abs(mouse_delta.y) < 80:
				moving_multi = 0
			elif abs(mouse_delta.y) > 80 && abs(mouse_delta.y) < 180:
				var t = (abs(mouse_delta.y) - 80) / (180 - 80) 
				moving_multi = 1 + t * (10 - 1)
			else:
				moving_multi  = 10
			if abs(mouse_delta.x) < 70:
				rotating_multi = 0
			elif abs(mouse_delta.x) > 70 && abs(mouse_delta.x) < 180:
				var t = (abs(mouse_delta.x) - 70) / (180 - 70) 
				rotating_multi = 1 + t * (5 - 1)
			else:
				rotating_multi = 5
			if mouse_delta.y < -5:
				moving_forward = true
				moving_backward = false
			elif mouse_delta.y > 5:
				moving_forward = false
				moving_backward = true
			if mouse_delta.x < -5:
				rotating_right = false
				rotating_left = true
			elif mouse_delta.x > 5: 
				rotating_right = true
				rotating_left = false
				

func _physics_process(delta: float) -> void:
	
	var direction = Vector3.ZERO
	direction = direction.rotated(Vector3.UP, rotation.y)
	if moving_forward: 
		direction.z -= 1 
	elif moving_backward: 
		direction.z += 1
	direction = direction.rotated(Vector3.UP, rotation.y)
	velocity = direction.normalized() * speed * moving_multi
	move_and_slide();
	if rotating_left:
		rotation.y += deg_to_rad(rotation_speed * rotating_multi)
	elif rotating_right:
		rotation.y -= deg_to_rad(rotation_speed * rotating_multi)
		
