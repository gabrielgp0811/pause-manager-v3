class_name PauseEventHandler, "res://pause-manager-v3/icon.png"
extends Node
## Used for handling pause/resume of a single Node
## 
## Author: Gabriel Pereira
## E-mail: gabrielgp0811@gmail.com
## Github: https://github.com/gabrielgp0811
## Discord: gabrielgp0811 | ggpereira#6599

# SIGNALS
signal toggle(paused)
signal pause
signal resume

func emit_toggle(paused: bool):
	emit_signal("toggle", paused)

func emit_pause():
	emit_signal("pause")

func emit_resume():
	emit_signal("resume")
