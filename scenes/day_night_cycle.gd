extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60 
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

var time:float = 0.0

@export var gradient: GradientTexture1D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	var value = (sin(time -(PI/6)+ 1.0))
	self.color = gradient.gradient.sample(value)
	
func recalulateTime() -> void:
	var totalMins = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	print(totalMins)
	
	var day = int(totalMins / MINUTES_PER_DAY)
	
	var currentDayMinutes = totalMins %  MINUTES_PER_DAY
	
	var hour = int(currentDayMinutes / MINUTES_PER_HOUR)
	var minute = int(currentDayMinutes % MINUTES_PER_HOUR)
