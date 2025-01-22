extends CharacterBody2D

const SPEED = 200.0  # Velocidade de movimento

# Variável para armazenar a última direção do personagem
var ultima_direcao = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	# Captura a entrada do jogador
	var input_direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	
	# Normaliza o vetor para movimentação consistente
	if input_direction != Vector2.ZERO:
		velocity = input_direction.normalized() * SPEED
		ultima_direcao = input_direction.normalized()  # Atualiza a última direção
		_atualizar_animacao_movimento(ultima_direcao)
	else:
		velocity = Vector2.ZERO  # Para o movimento
		_atualizar_animacao_parado()

	# Movimenta o personagem
	move_and_slide()

func _atualizar_animacao_movimento(direcao: Vector2):
	# Define a animação com base na direção do movimento
	if direcao.x > 0:  # Movendo para a direita
		$AnimatedSprite2D.play("walk_right")
	elif direcao.x < 0:  # Movendo para a esquerda
		$AnimatedSprite2D.play("walk_left")
	elif direcao.y > 0:  # Movendo para frente (baixo)
		$AnimatedSprite2D.play("walk_down")
	elif direcao.y < 0:  # Movendo para trás (cima)
		$AnimatedSprite2D.play("walk_up")

func _atualizar_animacao_parado():
	# Define a animação parado com base na última direção
	if ultima_direcao.x > 0:  # Parado olhando para a direita
		$AnimatedSprite2D.play("idle_right")
	elif ultima_direcao.x < 0:  # Parado olhando para a esquerda
		$AnimatedSprite2D.play("idle_left")
	elif ultima_direcao.y > 0:  # Parado olhando para frente
		$AnimatedSprite2D.play("idle_down")
	elif ultima_direcao.y < 0:  # Parado olhando para trás
		$AnimatedSprite2D.play("idle_up")
