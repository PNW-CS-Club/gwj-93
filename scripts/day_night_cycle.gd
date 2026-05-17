class_name DaylightCycle extends CanvasModulate

signal transition_finished(phase: Phase)

enum Phase { NIGHT, DAWN, DAY, DUSK }

@export var _gradient_texture: GradientTexture1D

const DURATION: float = 2.0            # how long it takes to transition (in seconds)

var _time: float = 0.0                # always between 0 and 1
var _curr_phase: Phase = Phase.NIGHT  # the state we most recently fully transitioned to
var _next_phase: Phase = Phase.NIGHT  # state we are transitioning to


func _ready():
	self.color = _calc_tint(_time, _curr_phase, _gradient_texture.gradient)

func _process(delta: float) -> void:
	if _next_phase == _curr_phase: return
	
	_time += delta / DURATION
	_time = clampf(_time, 0.0, 1.0)

	if _time >= 1.0:
		_curr_phase = _next_phase
		_time = 0.0
		transition_finished.emit(_next_phase)
	
	self.color = _calc_tint(_time, _curr_phase, _gradient_texture.gradient)


func _calc_tint(time: float, phase: Phase, gradient: Gradient):
	var value = ease(time, -2.0) * 0.25 + _phase_value(phase)
	return gradient.sample(value)


## returns the value on the gradient texture that corresponds to the given phase's color
func _phase_value(phase: Phase) -> float:
	match phase:
		Phase.DAWN: return 0.25
		Phase.DAY: return 0.50
		Phase.DUSK: return 0.75
		Phase.NIGHT: return 0.00
	printerr("bad phase value: " + str(phase))
	return -1;

## activates the transition to the given phase (it will take `duration` seconds)
func transition_to(phase: Phase) -> void:
	_next_phase = phase
