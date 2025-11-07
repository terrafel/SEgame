extends CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = -400.0

@onready var player_u1: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Tambahkan gravitasi
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle lompat
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		player_u1.animation = "jump"  # animasi lompat

	# Arah gerak kiri-kanan
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		player_u1.flip_h = direction < 0  # true kalau ke kiri
		velocity.x = direction * SPEED

		# Tampilkan animasi run hanya kalau di tanah
		if is_on_floor():
			player_u1.animation = "run"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

		# Kalau diam di tanah, animasi idle
		if is_on_floor():
			player_u1.animation = "idle"

	# Kalau di udara dan bukan saat loncat awal, tetap animasi jump
	if not is_on_floor() and player_u1.animation != "jump":
		player_u1.animation = "jump"

	move_and_slide()
