extends VehicleBody3D

@export var engine_force_multiplier: float

@export var steering_multiplier: float

@export var boost_capacity: float

@export var boost_force: float

var is_boosting:bool = false

var boost_amount:float

@onready var vehicle_requisites = $VehicleRequisites

@onready var back_left_wheel = $wheel_backLeft

var rpm = 0.0

var speed = 0.0

func _ready():
	boost_amount=boost_capacity
	vehicle_requisites.set_boost_meter_max(boost_capacity)

func _process(delta):
	speed = linear_velocity.length()
	speed *= 2.23694
	vehicle_requisites.update_speed(speed)
	if Input.is_action_pressed("boost"):
		if boost_amount>0:
			is_boosting=true
			boost_amount-=1*delta
			vehicle_requisites.change_speedometer_color()
		else:
			is_boosting=false
			vehicle_requisites.reset_speedometer_color()
	else:
		is_boosting=false
		vehicle_requisites.reset_speedometer_color()
		if boost_amount<boost_capacity and vehicle_requisites.get_cooldown_status():
			boost_amount+=1*delta
	if Input.is_action_just_released("boost"):
		vehicle_requisites.run_boost_cooldown()
	vehicle_requisites.update_boost_meter(boost_amount)

func _physics_process(delta):
	rpm = back_left_wheel.get_rpm()
	steering = lerp(steering, Input.get_axis("steer_right","steer_left")*steering_multiplier,5*delta)
	if !is_boosting:
		engine_force = Input.get_axis("accelerate","brake")*engine_force_multiplier
	if is_boosting:
		apply_central_force(basis.z*-boost_force)
		engine_force=-engine_force_multiplier
	vehicle_requisites.set_engine_pitch(rpm)

func screen_shake(amount:float):
	vehicle_requisites.screenshake(amount)

func get_speed():
	return speed
