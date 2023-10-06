extends CanvasLayer


func _on_PauseManager_toggle(paused):
	$"Pause Menu".visible = paused


func _on_Pause_Button_pressed():
	$PauseManager.toggle_pause()


func _on_Resume_Button_pressed():
	$PauseManager.toggle_pause()


func _on_Main_Scene_Button_pressed():
	$PauseManager.resume()
	get_tree().change_scene("res://pause-manager-v3/examples/example_scene.tscn")
