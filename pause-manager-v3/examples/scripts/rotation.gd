extends Panel

var speed : float = 2

func _process(delta):
	set_rotation(get_rotation() + speed * delta)


func _on_PauseEventHandler_toggle(paused):
	print(name, " - PauseEventHandler toggle: ", paused)
	set_process(not paused)


func _on_PauseEventHandler_pause():
	print(name, " - PauseEventHandler pause")
	set_process(false)


func _on_PauseEventHandler_resume():
	print(name, " - PauseEventHandler resume")
	set_process(true)


func toggle(paused: bool):
	print(name, " - Group toggle: ", paused)
	set_process(not paused)


func pause():
	print(name, " - Group pause")
	set_process(false)


func resume():
	print(name, " - Group resume")
	set_process(true)
