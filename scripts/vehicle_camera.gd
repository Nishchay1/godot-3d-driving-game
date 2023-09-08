extends Camera3D

# Higher values cause the field of view to increase more at high speeds.
const FOV_SPEED_FACTOR = 60

# Higher values cause the field of view to adapt to speed changes faster.
const FOV_SMOOTH_FACTOR = 0.2

const HEIGHT_SMOOTH_FACTOR = 0.2

# Don't change FOV if moving below this speed. This prevents shadows from flickering when driving slowly.
const FOV_CHANGE_MIN_SPEED = 0.05

var min_distance:float
var max_distance:float
var height:float
var original_height:float
var top_height:float

var initial_transform := transform

var base_fov := fov

# The field of view to smoothly interpolate to.
var desired_fov := fov

# Position on the last physics frame (used to measure speed).
@onready var previous_position := global_position

var shakeBaseAmount := 1.0
var shakeDampening := 0.075

var shakeAmount := 0.0

var height_change:bool = false

func _ready():
	set_as_top_level(true)

func _process(_delta):
	if shakeAmount > 0:
		h_offset = randf_range(-shakeAmount, shakeBaseAmount)*shakeAmount
		v_offset = randf_range(-shakeAmount, shakeBaseAmount)*shakeAmount
		shakeAmount = lerp(shakeAmount,0.0,shakeDampening)
	else:
		h_offset = 0
		v_offset = 0

func shake(magnitude: float):
	shakeAmount+=magnitude

func set_initial_values(min_dist:float,max_dist:float,h:float,adjusted_height:float):
	min_distance=min_dist
	max_distance=max_dist
	height=h
	top_height=adjusted_height
	original_height=h

func raise_height():
	height=top_height

func lower_height():
	height=original_height

func _physics_process(_delta):
	var target: Vector3 = get_parent().global_transform.origin
	var pos := global_transform.origin
	var from_target := pos - target
	# Check ranges.
	if from_target.length() < min_distance:
		from_target = from_target.normalized() * min_distance
	elif from_target.length() > max_distance:
		from_target = from_target.normalized() * max_distance
#	from_target.y = height
	from_target.y = lerpf(from_target.y, height, HEIGHT_SMOOTH_FACTOR) 
	pos = target + from_target

	look_at_from_position(pos, target, Vector3.UP)

	# Dynamic field of view based on car speed, with smoothing to prevent sudden changes on impact.
	desired_fov = clamp(base_fov + (abs(global_position.length() - previous_position.length()) - FOV_CHANGE_MIN_SPEED) * FOV_SPEED_FACTOR, base_fov, 100)
	fov = lerpf(fov, desired_fov, FOV_SMOOTH_FACTOR)

	previous_position = global_position

