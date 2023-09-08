extends Area3D


func _on_body_entered(body):
	if body.is_in_group("player"):
		var direction = (body.global_transform.origin - global_transform.origin).normalized()
		direction.y=randf_range(0.5,1)
		body.apply_central_impulse(direction * 2000)
		body.screen_shake(0.5)
		queue_free()
