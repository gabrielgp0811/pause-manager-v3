class_name PauseManager, "res://pause-manager-v3/icon.png"
extends Node
## A simple package for managing pause/resume using Signals.
## 
## Author: Gabriel Pereira
## E-mail: gabrielgp0811@gmail.com
## Github: https://github.com/gabrielgp0811
## Discord: gabrielgp0811 | ggpereira#6599

# SIGNALS
signal toggle(paused)
signal pause
signal resume

# CONSTANTS
const VERSION = "1.0.0"

# EXPORTED VARIABLES

## When 'true', the property 'paused' from get_tree() will be changed to 'true' when paused
## and changed to 'false' when resumed.
export (bool) var pause_tree = true

## When 'true', the 'pause' and 'resume' functions defined in all Nodes
## belonging from 'groups' Array below will be triggered.
export (bool) var pause_groups = true

## Array of groups to pause/resume a Node.
## Used when 'pause_groups' is 'true'.
export (Array, String) var groups = ["pausable"]

## When 'true', the 'pause' and 'resume' functions from 'PauseEventHandler' will be triggered.
export (bool) var use_event_handlers = true

## Use actions from Input Map? (Project -> Project Settings -> Input Map).
export (bool) var use_input_map= true

## Action names from Input Map (Project -> Project Settings -> Input Map).
## By default, there's only one action with the name 'pause'.
export (Array, String) var action_names = ["pause"]

## Array of keys, when Input Map is not needed.
## By default, there's only the 'Escape' key from keyboard.
export (Array, int) var keys = [KEY_ESCAPE]

# PRIVATE VARIABLES
var _paused : bool = false
var _input_event_pressed : bool = false

func _process(_delta):
	if use_input_map:
		for action_name in action_names:
			if Input.is_action_just_pressed(action_name):
				toggle_pause()

func _input(event):
	if not use_input_map and event is InputEventKey:
		if event.pressed:
			if not _input_event_pressed:
				_input_event_pressed = true
				toggle_pause()
		else:
			_input_event_pressed = false

func _notification(what):
	if what == NOTIFICATION_WM_FOCUS_OUT:
		pause()

func toggle_pause() -> void:
	emit_signal("toggle", not is_paused())

	if not is_paused():
		pause()
	else:
		resume()

func pause() -> void:
	if is_paused():
		return
	
	set_paused(true)
	
	emit_signal("pause")
	
	if pause_tree:
		get_tree().paused = true
	else:
		if pause_groups:
			for group in groups:
				get_tree().call_group(group, "toggle", true)
				get_tree().call_group(group, "pause")
		if use_event_handlers:
			lookup_handlers(get_tree().root, true)

func resume() -> void:
	if not is_paused():
		return
	
	set_paused(false)
	
	emit_signal("resume")
	
	get_tree().paused = false
	
	if not pause_tree:
		if pause_groups:
			for group in groups:
				get_tree().call_group(group, "toggle", false)
				get_tree().call_group(group, "resume")
		if use_event_handlers:
			lookup_handlers(get_tree().root, false)

func lookup_handlers(node : Node, pause : bool = true) -> void:
	var pause_event_handler_node
	for child in node.get_children():
		pause_event_handler_node = child.get_node_or_null("PauseEventHandler")
		
		if pause_event_handler_node != null:
			pause_event_handler_node.emit_toggle(pause)
			if pause:
				pause_event_handler_node.emit_pause()
			else:
				pause_event_handler_node.emit_resume()
		
		lookup_handlers(child, pause)

func append_action(action: String) -> void:
	for action_name in action_names:
		if action == action_name:
			return

	action_names.append(action)

func remove_action(action: String) -> void:
	var size = action_names.size()
	for position in size:
		if action == action_names[position]:
			remove_action_at(position)

func remove_action_at(position: int) -> void:
	if position > 0 and position < action_names.size():
		action_names.remove(position)

func set_paused(value: bool) -> void:
	_paused = value

func is_paused() -> bool:
	return _paused

func set_pause_tree(value: bool) -> void:
	if is_paused():
		return
	
	pause_tree = value

func is_pause_tree() -> bool:
	return pause_tree

func set_pause_groups(value: bool) -> void:
	if is_paused():
		return
	
	pause_groups = value

func is_pause_groups() -> bool:
	return pause_groups

func set_use_event_handlers(value: bool) -> void:
	if is_paused():
		return
	
	use_event_handlers = value

func is_use_event_handlers() -> bool:
	return use_event_handlers
