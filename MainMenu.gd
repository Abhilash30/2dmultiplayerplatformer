extends Control

@onready var room_list := $VBoxContainer/RoomList
@onready var host_button := $VBoxContainer/Host




func _on_host_button_down() -> void:
	HighLevelNetworkHandler.start_server()
	visible = false


func _on_join_button_down() -> void:
	HighLevelNetworkHandler.start_client()
	visible = false
	
