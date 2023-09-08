extends Node3D

@export var cam_min_distance := 4.0
@export var cam_max_distance := 6.0
@export var cam_height := 3.0


@export var adjusted_height = 5.0

@onready var speedometer = $UI/Speedometer/Label

@onready var boost_meter = $UI/BoostMeter

@onready var boost_cooldown = $BoostCooldown

@onready var vehicle_camera = $VehicleCamera

@onready var desired_engine_pitch: float = $EngineSound.pitch_scale

@onready var rotation_checker = $RotationChecker

func _ready():
	vehicle_camera.set_initial_values(cam_min_distance,cam_max_distance,cam_height,adjusted_height)

func update_speed(value):
	speedometer.text = "Speed: " + ("%.0f" % value) + " mph"

func update_boost_meter(value):
	boost_meter.value=value

func set_boost_meter_max(value):
	boost_meter.max_value=value

func run_boost_cooldown():
	boost_cooldown.start()

func get_cooldown_status():
	return boost_cooldown.is_stopped()

func screenshake(amount:float):
	vehicle_camera.shake(amount)

func change_speedometer_color():
	speedometer.modulate="F57513"

func reset_speedometer_color():
	speedometer.modulate="ffffff"

func set_engine_pitch(wheel_rpm):
	# Engine sound simulation (not realistic, as this car script has no notion of gear or engine RPM).
	desired_engine_pitch = clampf(abs(wheel_rpm)/1000.0, 1, 3.0)
	# Change pitch smoothly to avoid abrupt change on collision.
	$EngineSound.pitch_scale = lerpf($EngineSound.pitch_scale, desired_engine_pitch, 0.2)

func _on_camera_height_trigger_area_entered(area):
	if area.is_in_group("raise"):
		vehicle_camera.raise_height()
	if area.is_in_group("lower"):
		vehicle_camera.reset_height()
