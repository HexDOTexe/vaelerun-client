extends Control

@onready var chat_log = $VDIV/TabContainer/Chat/Box/Margin/ChatLog
@onready var lfg_log = $VDIV/TabContainer/LFG/Box/Margin/LFGLog
@onready var combat_log = $VDIV/TabContainer/Combat/Box/Margin/CombatLog
@onready var channel_label = $VDIV/HDIV/ChannelFrame/Margin/ChannelLabel
@onready var text_input_line = $VDIV/HDIV/TextInputFrame/Margin/TextInputLine

var message = ""

func _on_text_input_line_text_changed(new_text):
	message = new_text

func _on_text_input_line_focus_entered():
	UserInterface.chat_input_active = true

func _on_text_input_line_focus_exited():
	clear_text_input()
	UserInterface.chat_input_active = false

func _on_text_input_line_text_submitted(new_text):
	pass # Replace with function body.

func clear_text_input():
	text_input_line.clear()

func unfocus_chat_input():
	pass

#@rpc ("any_peer", "call_local")
func send_chat_message():
	if !message == "":
		Server.send_chat_event(message)
		text_input_line.clear()

func receive_chat_message(new_message):
	chat_log.text += new_message




