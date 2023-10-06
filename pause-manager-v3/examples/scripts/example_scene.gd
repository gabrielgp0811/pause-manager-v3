extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$PauseTreeCheckBox.pressed = $PauseManager.is_pause_tree()
	$PauseGroupsCheckBox.pressed = $PauseManager.is_pause_groups()
	$PauseEventHandlersCheckBox.pressed = $PauseManager.is_use_event_handlers()

func _on_PauseTreeCheckBox_toggled(button_pressed):
	$PauseManager.set_pause_tree(button_pressed)


func _on_PauseGroupsCheckBox_toggled(button_pressed):
	$PauseManager.set_pause_groups(button_pressed)


func _on_PauseEventHandlersCheckBox_toggled(button_pressed):
	$PauseManager.set_use_event_handlers(button_pressed)


func _on_Change_Scene_Button_pressed():
	get_tree().change_scene("res://pause-manager-v3/examples/example_pause_menu_scene.tscn")


func _on_PauseManager_toggle(paused):
	$PausedLabel.visible = paused
